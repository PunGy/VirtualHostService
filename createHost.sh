#!/bin/bash


# Config variables :

dirHost="/home/pungy/Hosts"; #Path to host directory
name=$1; #Name of host, it's passed by parameter
confFile="/etc/apache2/sites-available/$name.conf"; #Path to config file
toConf=$(cat hostConfig.txt);
ip="127.0.0.1" #Ip addres of server
logDir="$dirHost/log" #path to log directory

templateHello="Site is working" #Text in index.html
user=$(who | awk '{print $1}') #Name of user

#Checking on root
if [ "root" != $USER ]
then
  echo "You should execute script with a root privilege! (sudo ./createHost)"
  exit
fi


mkdir "$dirHost/$name"
touch "/etc/apache2/sites-available/$name.conf"
echo -e $toConf >> $confFile

mkdir "$dirHost/log/$name/"
touch "$dirHost/log/$name/error.log"
touch "$dirHost/log/$name/access.log"

touch $dirHost/$name/index.php
echo $templateHello >> $dirHost/$name/index.php

sed -i -e "1 s/^/127.0.0.1	$name\n/;" /etc/hosts

chown -R $user:$user "$dirHost/$name/"

a2ensite $name.conf
systemctl reload apache2

echo "Host is enabled!"


