#!/bin/bash 

echo 'Input password for ssh:'
read password

hosts='compute1 compute2 compute3 compute4'

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys

./ssh_key_scan.sh
cp ssh_known_hosts ~/.ssh/known_hosts

if [ -f /etc/lsb-release ]
then
 # Ubuntu

 cmd='sudo apt install sshpass --yes'

else

 # Rocky
 cmd='sudo dnf install sshpass -y'
fi

eval ${cmd}

for i in $hosts
do
   echo $i
   sshpass -p $password scp -r ~/.ssh/authorized_keys $i:.ssh

done
