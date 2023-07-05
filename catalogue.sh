echo -e "\e[36m configure nodejs repos \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[36m  Install nodejs \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[36m add application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log
rm -rf /app
mkdir /app
echo -e "\e[36m  download application content \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
echo -e "\e[36m extract application content \e[0m"
cd /app
unzip /tmp/catalogue.zip
echo -e "\e[36m Install nodejs dependencies \e[0m"
cd /app
npm install &>>/tmp/roboshop.log
echo -e "\e[36m setup systemd service \e[0m"
cp home/centos/Roboshop-shell/catalogue.service/etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[36m  start catalogue service \e[0m"

systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log

echo -e "\e[36m  copy mongodb repo file \e[0m"

echo -e "\e[36m  Install Mongodb client\ e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "\e[36m Load schema \e[0m"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js &>>/tmp/roboshop.log
