#!/bin/sh

UIDExists(){
    if getent passwd ${1} > /dev/null 2>&1; then
        echo 1
    else   
        echo 0
    fi
}

GroupExists(){
    if getent group ${1} > /dev/null 2>&1; then
        echo 1
    else   
        echo 0
    fi
}

PortInUse(){
    if netstat -tulpn | grep :${1} > /dev/null 2>&1; then
        echo 1
    else   
        echo 0
    fi
}