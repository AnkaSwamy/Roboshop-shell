echo -e "\e[31m Configure nodejs repos \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>>/tmp/roboshop.log

echo -e "\e[31m Install nodejs \e[0m"
yum install nodejs -y  &>>/tmp/roboshop.log

echo -e "\e[31m Add application user \e[0m"
useradd roboshop  &>>/tmp/roboshop.log

echo -e "\e[31m Create application directory \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[31m Download application content \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip   &>>/tmp/roboshop.log
cd /app

echo -e "\e[31m Extract application content \e[0m"
unzip /tmp/catalogue.zip  &>>/tmp/roboshop.log
cd /app

echo -e "\e[31m Install nodejs dependencies \e[0m"
npm install  &>>/tmp/roboshop.log

echo -e "\e[31m Setup systemd service \e[0m"
cp /root/Roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service  &>>/tmp/roboshop.log

echo -e "\e[31m  Start catalogue service \e[0m"
systemctl daemon-reload   &>>/tmp/roboshop.log
systemctl enable catalogue  &>>/tmp/roboshop.log
systemctl restart catalogue  &>>/tmp/roboshop.log

echo -e "\e[31m Copy mongodb repo file \e[0m"
cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>/tmp/roboshop.log

echo -e "\e[31m Install Mongodb client \e[0m"
yum install mongodb-org-shell -y  &>>/tmp/roboshop.log

echo -e "\e[31m Load Schema \e[0m"
mongo --host mongodb-dev.ankadevopsb73.store </app/schema/catalogue.js   &>>/tmp/roboshop.log

