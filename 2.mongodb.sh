echo -e "\e[31m Copying mongodb \e[0m"
cp mongo.repo /etc/yum.repos.d/mongodb.repo
echo -e "\e[34m Installing mongodb \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log
echo -e "\e[36m Update mongodb listen address \e[0m"
sed -i -e 's/127.0.0.0/0.0.0.0/' /etc/mongod.conf
echo -e "\e[33m start mongodb \e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
