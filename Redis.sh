echo -e "\e[31m  Installing Redis repos \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log
echo -e "\e[31m  Enable Redis 6th version \e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log
echo -e "\e[31m Install Redis server \e[0m"
yum install redis -y &>>/tmp/roboshop.log
echo -e "\e[31m update redis listen address \e[0m"
vim /etc/redis.conf & vim /etc/redis/redis.conf
echo -e "\e[31m  start redis service \e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl start redis  &>>/tmp/roboshop.log
