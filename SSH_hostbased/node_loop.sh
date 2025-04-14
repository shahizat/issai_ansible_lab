#!/bin/bash

#Host based SSH authentication setup on compute nodes

# Define the the compute node list:
hosts='compute1 compute2 compute3 compute4'

# create directory /etc/ssh/sshd_config.d if doesn't exist:
cmd1='[ -d /etc/ssh/sshd_config.d ] || mkdir /etc/ssh/sshd_config.d'


# Reference the directory in /etc/ssh/sshd_config: 
str='Include /etc/ssh/sshd_config.d/*.conf'

cmd2="grep -iF \"${str}\" /etc/ssh/sshd_config > /dev/null || echo \"${str}\" >> /etc/ssh/sshd_config"  


#Loop over the compute nodes
for i in ${hosts}
do

 echo $i
 scp {hosts.equiv,ssh_lci.conf,ssh_known_hosts,sshd_lci.conf} $i:/tmp
 ssh $i "sudo cp /tmp/hosts.equiv /etc"
 ssh $i "sudo cp /tmp/ssh_lci.conf /etc/ssh/ssh_config.d"
 ssh $i "sudo cp /tmp/ssh_known_hosts /etc/ssh"
 echo ${cmd1} | ssh $i sudo  /bin/bash -s 
 ssh $i "sudo cp /tmp/sshd_lci.conf /etc/ssh/sshd_config.d"
 echo ${cmd2} | ssh $i sudo  /bin/bash -s 
 ssh $i "sudo systemctl restart sshd"

done

# Configure ssh client on the head node:
sudo cp ssh_lci.conf /etc/ssh/ssh_config.d
sudo cp ssh_known_hosts /etc/ssh 
