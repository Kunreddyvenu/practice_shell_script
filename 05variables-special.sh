#!/bin/bash

echo "list of total variables: $@"
echo "number of varibales passed: $#"
echo "current script name: $0"
echo "current workign directory: $PWD"
echo "current home directory: $HOME"
echo "which user is runing this script: $USER"
echo "What is system hostname: $HOSTNAME"
echo "process id of the current shell script: $$"
sleep 50 &
echo "process id of the last background command: $!"
