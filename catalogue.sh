component= component
color="\e[31m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

echo -e " ${color} Configure nodejs repos ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>>${logfile}


echo -e "${color} Install nodejs ${nocolor}"
yum install nodejs -y  &>>${logfile}


echo -e "${color} Add application user ${nocolor}"
useradd roboshop  &>>${logfile}


echo -e "${color} Create application directory ${nocolor}"
rm -rf
mkdir ${app_path}

echo -e "${color} Download application content ${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip   &>>${logfile}
cd ${app_path}

echo -e "${color} Extract application content ${nocolor}"
unzip /tmp/$component.zip  &>>${logfile}
cd ${app_path}

echo -e "${color} Install nodejs dependencies ${nocolor}"
npm install  &>>${logfile}

echo -e "${color} Setup systemd service ${nocolor}"
cp /root/Roboshop-shell/$component.service /etc/systemd/system/$component.service  &>>${logfile}


echo -e "${color}  Start the $component service ${nocolor}"
systemctl daemon-reload   &>>${logfile}

systemctl enable $component  &>>${logfile}

systemctl restart $component  &>>${logfile}


echo -e "${color} Copy mongodb repo file ${nocolor}"
cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>${logfile}


echo -e "${color} Install Mongodb client ${nocolor}"
yum install mongodb-org-shell -y  &>>${logfile}


echo -e "${color} Load Schema ${nocolor}"
mongo --host mongodb-dev.ankadevopsb73.store <${app_path}/schema/$component.js   &>>${logfile}

