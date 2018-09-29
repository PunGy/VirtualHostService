#!/bin/bash

# Config variables :

dirHost="/home/pungy/Hosts"; #Path to host directory
name=$1; #Name of host, it's passed by parameter
confFile="/etc/apache2/sites-available/$name.conf"; #Path to config file
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

#if argument lose - break with message
if [ -z $name ]
then
        echo "ERROR: You should add argument (sudo ./createHost example)"
        exit
fi


if [ -e "$confDir/$name.conf" ]
then
	a2dissite $name.conf > /dev/null
	rm -rf "$dirHost/$name"
	rm -rf "$logDir/$name";
	rm "$confDir/$name.conf"
	sed -i "/$name/d" /etc/hosts
	systemctl reload apache2 >> /dev/null
	
	echo "Removing successfully"
else
  echo "File not exist"
fi
