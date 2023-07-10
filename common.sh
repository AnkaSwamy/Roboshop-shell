color="\e[31m"
nocolor="\e[0m"
app_path="/app"
log_file="/tmp/roboshop.log"

nodejs() {
  echo -e "${color} Configure nodejs repos ${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>>$log_file

  echo -e "${color} Install nodejs ${nocolor}"
  yum install nodejs -y  &>>$log_file

  echo -e "${color} Add application user ${nocolor}"
  useradd roboshop  &>>$log_file

  echo -e "${color} Create application directory ${nocolor}"
  rm -rf
  mkdir ${app_path}  &>>$log_file

  echo -e "${color} Download application content ${nocolor}"
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip   &>>$log_file
  cd ${app_path}

  echo -e "${color} Extract application content ${nocolor}"
  unzip /tmp/$component.zip  &>>$log_file
  cd ${app_path}

  echo -e "${color} Install nodejs dependencies ${nocolor}"
  npm install  &>>$log_file

  echo -e "${color} Setup systemd service ${nocolor}"
  cp /root/Roboshop-shell/$component.service /etc/systemd/system/$component.service  &>>$log_file

  echo -e "${color}  Start the $component service ${nocolor}"
  systemctl daemon-reload   &>>$log_file
  systemctl enable $component  &>>$log_file
  systemctl restart $component  &>>$log_file

  echo -e "${color} Copy mongodb repo file ${nocolor}"
  cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>$log_file

  echo -e "${color} Install Mongodb client ${nocolor}"
  yum install mongodb-org-shell -y  &>>$log_file
}
mongo_schema_setup() {
  echo -e "\e[31m  copy mongodb repo file \e[0m"
  cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>/tmp/roboshop.log

  echo -e "\e[31m  Install Mongodb client \e[0m"
  yum install mongodb-org-shell -y  &>>/tmp/roboshop.log

  echo -e "\e[31m Load schema \e[0m"
  mongo --host mongodb-dev.ankadevopsb73.store </app/schema/user.js  &>>/tmp/roboshop.log
}