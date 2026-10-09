#!/bin/bash
USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "Please enter DB password:"
read -s mysql_root_password

VALIDATE(){
    if [ $1 -ne 0 ]
    then
    echo -e "$2....$R FAILURE $N"
    exit 1
    else
    echo -e "$2 ....$G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
echo "please run this script using root access"
exit 1 #manually exit if error comes
else
echo "you are root user"
fi

dnf module disable nodejs -y &>>$LOGFILE
VALIDATE $? "Disabling default nodejs"

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "enabling nodejs 20 version"

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "installing nodejs"
id expense &>>$LOGFILE
if [ $? -ne 0 ] 
then
    useradd expense &>>$LOGFILE
    VALIDATE $? "creating expense user"
else
    echo -e "expense user already created".. $Y SKIPPING $N
 fi       

#Below command -p will check app directory if not there it will create else silence
 mkdir -p /app &>>$LOGFILE 
 VALIDATE $? "creating app directory"

 curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading backend code"

cd app
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "extracted backend code"

npm install &>>$LOGFILE
VALIDATE $? "installing nodejs dependecies"

cp/home/ec2-user/practice_shell_script/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "Copied backend service"

systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Daemon reload"

systemctl start backend &>>$LOGFILE
VALIDATE $? "starting backend service"

systemctl enbale backend &>>$LOGFILE
VALIDATE $? "enabling backend service"

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "installing MYSQL client"

mysql -h 172.31.45.255  -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "Schema loading"

systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restarting Backend"








