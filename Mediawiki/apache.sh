cd /tmp
echo "\e[35m Downloading mediawiki \e[0m"
url="https://releases.wikimedia.org/mediawiki/1.40/mediawiki-1.40.0.tar.gz"
curl -O $url &>>$tmp/roboshop.log
folder=$(echo $url | awk -f / '{print $6}'| sed 's/.tar.gz//')

echo "\e[35m Installing httpd \e[0m"
yum install httpd -y  &>>$tmp/roboshop.log

echo "\e[35m remove old content \e[0m"
rm -rf /var/www/html/*  &>>$tmp/roboshop.log
cd /var/www/html

echo "\e[35m Extract httpd file \e[0m"
tar -xf /tmp/mediawiki-1.40.0.tar.gz  &>>$tmp/roboshop.log

echo "\e[35m rename folder as  mediawiki \e[0m"
mv $folder Mediawiki  &>>$tmp/roboshop.log