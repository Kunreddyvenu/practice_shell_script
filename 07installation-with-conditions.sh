#!/bin/bash

dnf install mysql -y

if [ $? -ne 0 ]
then
    echo "you are not a super user"
    exit 1
# if you want to exit here it self you can use exit command like exit 1-127
else 
    echo "you are a super user"
fi

dnf install git -y

if [ $? -ne 0 ]
then
    echo "run this command with super user"
    exit 1
else
    echo "installation of git success"
fi        
