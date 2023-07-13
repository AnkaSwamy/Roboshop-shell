cd /tmp
echo "\e[35m" Downloading mediawiki "\e[0m"
url="https://releases.wikimedia.org/mediawiki/1.40/mediawiki-1.40.0.tar.gz" &>>$tmp/roboshop.log
curl -O $url &>>$tmp/roboshop.log
folder=$(echo $url | awk -f | '{print $6}'| sed 's/.tar.gz/')
yum install httpd -y  &>>$tmp/roboshop.log
rm -rf /var/www/html  &>>$tmp/roboshop.log
cd /var/www/html
tar -xf /tmp/mediawiki-1.40.0.tar.gz  &>>$tmp/roboshop.log
mv $folder Mediawiki  &>>$tmp/roboshop.log