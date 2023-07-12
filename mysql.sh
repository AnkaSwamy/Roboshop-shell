echo -e "\e[31m Disable mysql default version \e[0m"
yum module disable mysql -y  &>>/tmp/roboshop.log

echo -e "\e[31m Copy mysql repo file \e[0m"
 cp /root/Roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo  &>>/tmp/roboshop.log

echo -e "\e[31m Install mysql community server \e[0m"
yum install mysql-community-server -y  &>>/tmp/roboshop.log

echo -e "\e[31m start my sql service \e[0m"
systemctl enable mysqld  &>>/tmp/roboshop.log
systemctl restart mysqld  &>>/tmp/roboshop.log

echo -e "\e[31m  set up mysql password\e[0m"
mysql_secure_installation --set-root-pass $1  &>>/tmp/roboshop.log