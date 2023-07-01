echo -e "\e[31m Copying mongodb \e[0m"
cp mongo.repo /etc/yum.repos.d/mongodb.repo
echo -e "\e[34m Installing mongodb \e[0m"
yum install mongodb-org -y
echo -e "\e[33m start mongodb \e[0m"
systemctl enable mongod
systemctl restart mongod