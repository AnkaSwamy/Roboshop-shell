echo -e "\e[31m Copy mongodb repo file \e[0m"
cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>/tmp/roboshop.log

echo -e "\e[31m Installing mongodb server \e[0m"
yum install mongodb-org -y  &>>/tmp/roboshop.log

echo -e "\e[31m Update mongodb listen address \e[0m"
sed -i  's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[31m Start mongodb server \e[0m"
systemctl enable mongod  &>>/tmp/roboshop.log
systemctl restart mongod  &>>/tmp/roboshop.log
