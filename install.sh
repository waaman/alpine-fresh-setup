#!/bin/sh


echo "-------------------------------------------------------------------------------------"
echo "|        Script d'installation de base pour Alpine Linux. Waaman / v0.0.1           |" 
echo "|   Support: https://github.com/waaman/alpine-fresh-setup/issues              |"
echo "|   Licence: https://github.com/waaman/alpine-fresh-setup/blob/main/LICENSE   |"
echo "-------------------------------------------------------------------------------------"

echo "Ce script est fourni comme tel. Sans garantie de résultat et sous la Licence BSD 2-Clause Simplified License."
echo "Vous comprenez et acceptez ces termes ? (o/N)"
read accept

if [ ${accept} = n ]
then
    exit
    rm -R install.sh
fi


#################################################################
##  Les dépôts de départ avec le community activé
#################################################################
echo "Modifications des dépôts"
cat > /etc/apk/repositories << EOF; $(echo)
https://dl-cdn.alpinelinux.org/alpine/v$(cut -d'.' -f1,2 /etc/alpine-release)/main/
https://dl-cdn.alpinelinux.org/alpine/v$(cut -d'.' -f1,2 /etc/alpine-release)/community/
#https://dl-cdn.alpinelinux.org/alpine/edge/testing/
EOF


#################################################################
##  Mises à jour des dépôts et installation de paquets de base
#################################################################
echo "Installation de paquets utiles: nano git sudo curl tree"
apk update > /dev/null && apk add nano git sudo curl tree > /dev/null


#################################################################
##  Le groupe wheel sera autorisé à sudo
#################################################################
echo "Le groupe wheel sera autorisé à sudo"
echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel


#################################################################
##  Montage auto des partages distants listés dans /etc/fstab
#################################################################
echo "Montage auto activé pour les partages distants listés dans /etc/fstab"
rc-update add netmount boot


#################################################################
##  On récupère les sources sur github
#################################################################
echo "Récupération des scripts sur github"
if [ -d "workdir" ]
then
    rm -R workdir/
fi
git clone --quiet https://github.com/waaman/alpine-fresh-setup.git workdir
cd workdir
chmod a+x scripts/*.sh

echo "Installation via https://github.com/waaman/alpine-fresh-setup/" >> motd
echo "Ce pense bête se trouve dans /etc/motd" >> motd
printf "\n" >> motd


#################################################################
##  On exécute les scripts un à un
#################################################################
for f in ./scripts/*.sh; do
    sh "$f"
done

# Le motd sera remplacé par celui remplis au fil des scripts
rm /etc/motd
cp motd /etc/motd


#################################################################
##  On supprime les sources github
#################################################################
#cd .. && rm -R workdir/ install.sh