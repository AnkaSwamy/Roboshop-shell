echo -e "\e[31m Configure erlang repos \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash  &>>/tmp/roboshop.log

echo -e "\e[31m Configure rabbitmq repos \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash  &>>/tmp/roboshop.log
echo -e "\e[31m Install rabbitmq server \e[0m"
yum install rabbitmq-server -y  &>>/tmp/roboshop.log

echo -e "\e[31m Start rabbitmq service \e[0m"
systemctl enable rabbitmq-server  &>>/tmp/roboshop.log
systemctl start rabbitmq-server   &>>/tmp/roboshop.log

echo -e "\e[31m Add rabbitmq application user \e[0m"
rabbitmqctl add_user roboshop roboshop123   &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"   &>>/tmp/roboshop.log