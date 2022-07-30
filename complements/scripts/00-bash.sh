#!/bin/sh

echo "--------------------------------------------------------"
echo "complements/scripts/00-bash.sh"
echo "--------------------------------------------------------"


ROOT_DIR=$(dirname $(readlink -f $0))/../..

echo "Voulez vous utilisez bash à la place de ash ?"
echo "(o/N)"
read bash

if [ ! ${bash} = n ]
then

    # Lecture des données saisies ultèrieurement et stockées dans des fichiers individuels
    read -r name < $ROOT_DIR/user_name
    read -r group < $ROOT_DIR/user_group

    apk add bash bash-doc bash-completion

    # On va créer .profile et .bashrc
    sudo -u ${name} echo "exec /bin/bash" > /home/${name}/.profile
    sudo -u ${name} echo "source /etc/profile.d/bash_completion.sh" > /home/${name}/.bashrc
    sudo -u ${name} echo 'export PS1="\[\e[31m\][\[\e[m\]\[\e[38;5;172m\]\u\[\e[m\]@\[\e[38;5;153m\]\h\[\e[m\] \[\e[38;5;214m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "' >> /home/${name}/.bashrc

    echo "exec /bin/bash" > /root/.profile
    echo "source /etc/profile.d/bash_completion.sh" > /root/.bashrc
    echo 'export PS1="\[\e[31m\][\[\e[m\]\[\e[38;5;172m\]\u\[\e[m\]@\[\e[38;5;153m\]\h\[\e[m\] \[\e[38;5;214m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "' >> /root/.bashrc


    # Change shell of existing users.
    sed -e 's;/bin/ash$;/bin/bash;g' -i /etc/passwd

fi