#!/bin/sh

UIDExists(){
    if getent passwd $1 > /dev/null; then
        echo true
    else   
        echo false
    fi
}

GroupExists(){
    if getent group $1 > /dev/null; then
        echo true
    else   
        echo false
    fi
}

PortInUse(){
    if netstat -tulpn | grep :$1 > /dev/null; then
        echo true
    else   
        echo false
    fi
}