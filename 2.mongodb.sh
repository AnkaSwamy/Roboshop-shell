echo -e "\e[31m Copying mongodb repo \e[0m"
cp mongo.repo /etc/yum.repos.d/mongodb.repo

echo -e "\e[31m Installing mongodb \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.

echo -e "\e[31m Update mongodb listen address \e[0m"
sed -i  's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[31m start mongodb \e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
