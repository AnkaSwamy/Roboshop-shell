echo -e "\e[31m configure nodejs repos \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[31m  Install nodejs \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[31m add application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[31m Create application directory \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[31m  download application content \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[31m extract Application content \e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log

echo -e "\e[31m Install nodejs dependencies \e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[31m setup systemd service \e[0m"
cp /root/Roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[31m  start catalogue service \e[0m"

systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log

echo -e "\e[31m  copy mongodb repo file \e[0m"
cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e "\e[31m  Install Mongodb client \e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[31m Load schema \e[0m"
mongo --host mongodb-dev.ankadevopsb73.store </app/schema/catalogue.js &>>/tmp/roboshop.log
