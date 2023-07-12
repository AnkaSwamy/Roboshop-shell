color="\e[31m"
nocolor="\e[0m"
app_path="/app"
log_file="/tmp/roboshop.log"

  app_presetup() {
    echo -e "${color} Add application user ${nocolor}"
    useradd roboshop  &>>$log_file
    if [ $? -eq 0 ]; then
      echo SUCCESS
      else
        echo FAILURE
        fi

    echo -e "${color} Create application directory ${nocolor}"
    rm -rf
    mkdir ${app_path}  &>>$log_file
    echo $?

    echo -e "${color} Download application content ${nocolor}"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip   &>>$log_file
    cd ${app_path}
    if [ $? -eq 0 ]; then
         echo SUCCESS
         else
           echo FAILURE
           fi

    echo -e "${color} Extract application content ${nocolor}"
    unzip /tmp/${component}.zip  &>>$log_file
    cd ${app_path}
    if [ $? -eq 0 ]; then
         echo SUCCESS
         else
           echo FAILURE
           fi
    }

  systemd_setup() {
    echo -e "${color} Setup systemd service ${nocolor}"
    cp /root/Roboshop-shell/${component}.service /etc/systemd/system/${component}.service  &>>$log_file
     if [ $? -eq 0 ]; then
          echo SUCCESS
          else
            echo FAILURE
            fi

    echo -e "${color}  Start the ${component} service ${nocolor}"
    systemctl daemon-reload   &>>$log_file
    systemctl enable ${component}  &>>$log_file
    systemctl restart ${component} &>>$log_file
     if [ $? -eq 0 ]; then
          echo SUCCESS
          else
            echo FAILURE
            fi


    }
  nodejs() {
    echo -e "${color} Configure nodejs repos ${nocolor}"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>>$log_file
    echo -e "${color} Install nodejs ${nocolor}"
    yum install nodejs -y  &>>$log_file
    app_presetup

    echo -e "${color} Install nodejs dependencies ${nocolor}"
    npm install  &>>$log_file


    systemd_setup
    }

  mongo_schema_setup() {
    echo -e "${color}  copy mongodb repo file ${nocolor}"
    cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>$log_file
    echo -e "${color}  Install Mongodb client ${nocolor}"
    yum install mongodb-org-shell -y  &>>$log_file
    echo -e "${color} Load schema ${nocolor}"
    mongo --host mongodb-dev.ankadevopsb73.store <${app_path}/schema/${component}.js  &>>$log_file
    }

  mysql_schema_setup() {
    echo -e "\e[31m Install mysql client \e[0m"
    yum install mysql -y  &>>/tmp/roboshop.log
    echo -e "\e[31m load schema \e[0m"
    mysql -h  mysql-dev.ankadevopsb73.store -uroot -pRoboShop@1 < /app/schema/shipping.sql   &>>/tmp/roboshop.log
    }
  maven() {
    echo -e "${color}  Install maven ${nocolor}"
    yum install maven -y  &>>$log_file
    app_presetup

    echo -e "${color}  Download maven dependencies ${nocolor}"
    mvn clean package
    mv target/${component}-1.0.jar ${component}.jar

    mysql_schema_setup

    systemd_setup
   }
  python() {
    echo -e "\e[31m Install python \e[0m"
    yum install python36 gcc python3-devel -y  &>>/tmp/roboshop.log
     if [ $? -eq 0 ]; then
          echo SUCCESS
          else
            echo FAILURE
            fi

    app_presetup

    echo -e "\e[31m Install application dependencies \e[0m"
    cd /app
    pip3.6 install -r requirements.txt  &>>/tmp/roboshop.log
     if [ $? -eq 0 ]; then
          echo SUCCESS
          else
            echo FAILURE
            fi

    systemd_setup
  }
