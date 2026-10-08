#!/bin/bash
USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "please enter DB password:"
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

if [$USERID -ne 0 ]
then
echo "please run this script using root access"
exit 1 #manually exit if error comes
else
echo "you are root user"
fi

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "instalng mysql server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "enabling mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "starting mysql server"

# mysql_secure_installation --set--root--pass ExpenseApp@1 &>>$LOGFILE
# VALIDATE $? "setting up root password" 

mysql_h 172.31.45.255 -uroot -p${mysql_root_pasword} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    VALIDATE $? "MySQL Root password Setup"
else
    echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
fi