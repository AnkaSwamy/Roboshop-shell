source common.sh

echo -e "${color} Installing Nginx server ${nocolor} "
yum install nginx -y &>>$log_file

echo -e "${color} Remove default content ${nocolor}"
rm -rf /usr/share/nginx/html/* &>>$log_file

echo -e "${color} Download frontend content ${nocolor}""
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file

echo -e "${color} Extract frontend content ${nocolor}"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$log_file

echo -e "${color} Update the configuration ${nocolor}""
cp /root/Roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf  &>>$log_file

echo -e "${color} Start nginx server ${nocolor}"
systemctl enable nginx &>>$log_file
systemctl restart nginx  &>>$log_file