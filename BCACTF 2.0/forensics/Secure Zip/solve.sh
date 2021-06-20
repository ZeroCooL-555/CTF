#!/bin/bash

password=$(fcrackzip -D -p /usr/share/wordlists/rockyou.txt -v -u chall.zip | grep -ioP "==.{0,10}" | sed 's/==//')
unzip -q -P $password chall.zip
cat flag.txt
echo "" 
rm flag.txt
rm homework.txt
