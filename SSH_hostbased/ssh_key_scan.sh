#!/bin/bash

hosts='head compute1 compute2 compute3 compute4 
192.168.0.4 192.168.0.5 192.168.0.6 192.168.0.7 192.168.0.8' 

rm ssh_known_hosts

for i in $hosts
do

#ssh-keyscan -t rsa $i >> ~/.ssh/known_hosts
ssh-keyscan -t rsa $i >> ssh_known_hosts
 

done

