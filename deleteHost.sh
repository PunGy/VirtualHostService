#!/bin/bash

# Config variables :

dirHost="/home/pungy/Hosts"; #Path to host directory
name=$1; #Name of host, it's passed by parameter
confFile="/etc/apache2/sites-available/$name.conf"; #Path to config file
toConf=$(cat hostConfig.txt);
ip="127.0.0.1" #Ip addres of server
logDir="$dirHost/log" #path to log directory
confDir="/etc/apache2/sites-available"

templateHello="Site is working" #Text in index.html
user=$(who | awk '{print $1}') #Name of user

#Checking on root
if [ "root" != $USER ]
then
  echo "You should execute script with a root privilege! (sudo ./createHost)"
  exit
fi

if [ -e "$confDir/$name.conf" ]
then
	a2dissite $name.conf
	rm -rf "$dirHost/$name"
	rm -rf "$logDir/$name";
	rm "$confDir/$name.conf"
	systemctl reload apache2
	
	echo "Remowing success"
else
  echo "File not exist"
fi
