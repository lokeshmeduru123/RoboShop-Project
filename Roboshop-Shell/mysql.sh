#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2...$R FAILURE $N"
        exit 1
    else
        echo -e "$2...$G SUCESS $N"
    fi
    }

if [ $USERID -ne 0 ]
then 
    echo "your are not a root user"
    exit 1
else
    echo "you are a root user"
fi


dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing MySQL Server"     

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling MySQL server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting MySQL Server"

mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOGFILE
VALIDATE $? "Setting root password"