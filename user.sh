echo -e "\e[31m Configure Nodejs repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[31m  Install Nodejs \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[31m Add Application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[31m create application directory \e[0m"
rm -rf /app
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[31m Download app content \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[31m Extract application content \e[0m"
unzip /tmp/user.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[31m Install nodejs dependencies \e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[31m setup systemd service \e[0m"
cp /root/Roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log

echo -e "\e[31m  start user service \e[0m"
systemctl daemon-reload
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log

echo -e "\e[31m  copy mongodb repo file \e[0m"
cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[31m  Install Mongodb client \e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[31m Load schema \e[0m"
mongo --host mongodb-dev.ankadevopsb73.store </app/schema/user.js &>>/tmp/roboshop.log
