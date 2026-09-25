#!/bin/bash

dnf install mysql -y

if [ $? -ne 0 ]
then
    echo "you are not a super user"
else 
    echo "you are a super user"
fi

echo "please run this command with super user"
