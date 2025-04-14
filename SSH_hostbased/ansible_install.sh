#!/bin/bash

if [ -f /etc/lsb-release ]
then
 # Ubuntu

 cmd='sudo apt-add-repository ppa:ansible/ansible --yes; sudo apt update;  sudo apt install ansible --yes'
else
 # Rocky
 cmd='sudo dnf install -y ansible-core'
fi

eval ${cmd}

hosts='compute1 compute2 compute3 compute4'

for i in $hosts
do

 ssh $i  ${cmd} 

done
