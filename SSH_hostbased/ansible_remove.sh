#!/bin/bash

if [ -f /etc/lsb-release ]
then
 # Ubuntu
 cmd='sudo apt remove ansible --purge --yes'
else
 # Rocky
 cmd='sudo dnf erase -y ansible-core'
fi

eval ${cmd}

hosts='compute1 compute2 compute3 compute4'

for i in $hosts
do

 ssh $i  ${cmd} 

done
