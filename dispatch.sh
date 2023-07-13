echo -e "${color} Install golang  ${nocolor}"
yum install golang -y  &>>$log_file

echo -e "${color} add application user ${nocolor}"
useradd roboshop  &>>$log_file

echo -e "${color} create application directory ${nocolor}"
rm -rf /app  &>>$log_file
mkdir /app &>>$log_file

echo -e "${color} Download Application content ${nocolor}"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip  &>>$log_file
cd /app

echo -e "${color} Extract application content ${nocolor}"
unzip /tmp/dispatch.zip  &>>$log_file

echo -e "${color} download the dependencies & build the software
${nocolor}"
cd /app
go mod init dispatch  &>>$log_file
go get  &>>$log_file
go build  &>>$log_file

echo -e "${color}  setup systemd service ${nocolor}"
cp /root/Roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service   &>>$log_file

echo -e "${color} start dispatch service  ${nocolor}"
systemctl daemon-reload  &>>$log_file
systemctl enable dispatch  &>>$log_file
systemctl restart dispatch  &>>$log_file

