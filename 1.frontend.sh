echo -e "\e[36m Installing Nginx server \e[0m"
yum install nginx -y &>>/tmp/roboshop.log
echo -e "\e[35m remove default content \e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[34m Download frontend content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log
echo -e "\e[33m Extract frontend content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log
#configuration file
echo -e "\e[32m start nginx server \e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log