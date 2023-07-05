echo -e "\e[31m Installing Nginx server \e[0m"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "\e[31m remove default content \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e[31m Download frontend content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[31m Extract frontend content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[31m update configuration \e[0m"
cp /root/Roboshop-shell/roboshop.conf/etc/nginx/default.d/roboshop.conf

echo -e "\e[31m start nginx server \e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log