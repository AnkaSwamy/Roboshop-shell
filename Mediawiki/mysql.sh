cd /tmp
echo "\e[35m" Downloading mediawiki "\e[0m"
url="https://releases.wikimedia.org/mediawiki/1.40/mediawiki-1.40.0.tar.gz"
curl -O $url
folder=$(echo $url | awk -f | '{print $6}'| sed 's/.tar.gz/')
yum install httpd -y
rm -rf /var/www/html
cd /var/www/html
tar -xf /tmp/mediawiki-1.40.0.tar.gz
mv $folder Mediawiki