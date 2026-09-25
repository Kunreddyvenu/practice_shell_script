#!/bin/bash

dnf install mysql -y

if [ $? -ne 0 ]
then
    echo "you are not a super user"
elase 
    echo "you are a super user"
fi
    