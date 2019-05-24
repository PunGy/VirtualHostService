#!/bin/bash


# Config variables :
name=$1; #Name of host, it's passed by parameter
dirHost="/home/$name/Hosts"; #Path to host directory
confFile="/etc/apache2/sites-available/$name.conf"; #Path to config file
ip="127.0.0.1" #Ip addres of server
logDir="$dirHost/log" #path to log directory

#CONFIG OF VIRTUAL HOST
toConf="
<VirtualHost *:80>\n
    ServerName $name\n
    DocumentRoot $dirHost/$name/\n
ErrorLog $dirHost/log/$name/error.log\n
CustomLog $dirHost/log/$name/access.log combined\n
<Directory $dirHost/$name>\n
        AllowOverride All\n
        Options Indexes FollowSymlinks\n
        Require all granted\n
    </Directory>\n
</VirtualHost>
"


templateHello=$(cat helloPage.html) > /dev/null #Text in index.html

user=$(who | awk '{print $1}') #Name of user

#Checking on root
if [ "root" != $USER ]
then
  echo "ERROR: You should execute script with a root privilege! (sudo ./createHost example)"
  exit
fi

#if argument lose - break with message
if [ -z $name ]
then
	echo "ERROR: You should add argument (sudo ./createHost example)"
	exit
fi


mkdir "$dirHost/$name"
touch "/etc/apache2/sites-available/$name.conf"
echo -e $toConf >> $confFile

mkdir "$dirHost/log/$name/"
touch "$dirHost/log/$name/error.log"
touch "$dirHost/log/$name/access.log"

touch $dirHost/$name/index.html
echo $templateHello >> $dirHost/$name/index.html

sed -i -e "1 s/^/127.0.0.1	$name\n/;" /etc/hosts

chown -R $user:$user "$dirHost/$name/"

a2ensite $name.conf > /dev/null
systemctl reload apache2 > /dev/null

echo "Host is enabled!"
