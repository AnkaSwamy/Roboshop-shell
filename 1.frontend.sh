echo -e "\e[36m Installing Nginx server \ e[0m"
yum install nginx -y
echo -e "\e[36m remove default content \ e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[36m Download frontend content \ e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[36m Extract frontend content \ e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
#configuration file
echo -e "\e[36m start nginx server \ e[0m"
systemctl enable nginx
systemctl restart nginx