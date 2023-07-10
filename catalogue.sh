source common.sh
component =${catalogue}

nodejs()
mongo_schema_setup
echo -e "${color} Load schema ${nocolor}"
mongo --host mongodb-dev.ankadevopsb73.store <${app_path}/schema/$component.js   &>>$log_file