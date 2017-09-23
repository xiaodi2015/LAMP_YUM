#!/bin/bash
#Version: 1.0
#Author: A_xiaosu
#Date: 2017-09-23
#Description: LAMP install script
$checkNetWork = $(ping gitee.com -c 5 | grep "min/avg/max" -c)
if [ $checkNetWork -eq 0 ]
then 
  printf "Error:You netWork error! "
  exit 1
fi

if [ "$UID" -ne 0 ]
then 
  printf "Error:You must be root to run this script! \n"
  exit 1
fi

echo " welcome to use the Script "

echo " we will start install Apache , please wating..."

yum update -y

yum install httpd -y

chkconfig httpd on 

yum -y install httpd-manual mod_ssl mod_perl mod_auth_mysql

service httpd start 

echo "Apache is install commplete!"
sleep 5

echo "we will install mysql-server "
sleep 3

yum -y install mysql mysql-server mysql-devel

chkconfig mysqld on

service mysql start

echo "Then we will Initialization the mysql setting. You can set the mysql password according to hints. "

sleep 0.1

echo "Do you want set You mysql?Y/N"

read -p select_id

if [ $select_id eq "Y" ]
then
  mysql_secure_installation
fi

echo "mysql install commplete!"

sleep 1

echo "
             Please Select Install
    # ---------------------------------------
    1 --- PHP 5.3			  ---
    2 --- PHP 5.5			  ---
    3 --- PHP 5.6			  ---
    # ------------------------------------
"
sleep 0.1
read -p "Please Input 1,2,3: " change

if [ $change == 1 ]
then
yum -y install php php-mysql
yum -y install gd php-gd gd-devel php-xml php-common php-mbstring php-ldap php-pear php-xmlrpc php-imap 
elif [ $change == 2 ]; then
	rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
	yum install php55w.x86_64 php55w-cli.x86_64 php55w-common.x86_64 php55w-gd.x86_64 php55w-ldap.x86_64 php55w-mbstring.x86_64 php55w-mcrypt.x86_64 php55w-mysql.x86_64 php55w-pdo.x86_64
	yum -y install php55w-fpm
else [ $change == 3 ];then
	rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
	yum install php56w.x86_64 php56w-cli.x86_64 php56w-common.x86_64 php56w-gd.x86_64 php56w-ldap.x86_64 php56w-mbstring.x86_64 php56w-mcrypt.x86_64 php56w-mysql.x86_64 php56w-pdo.x86_64
	yum -y install php56w-fpm
else 
	echo "no select id ,exit...."
	exit 1
fi


