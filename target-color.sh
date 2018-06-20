#!/bin/bash
current_color=$1
if [ "$current_color" = 'blue' ];then
    target_color='green'
elif [ "$current_color" = 'green' ];then
    target_color='blue'
else
    target_color='blue'
fi
echo -e "$target_color\c"