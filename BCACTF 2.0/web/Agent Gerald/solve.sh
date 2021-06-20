#!/bin/bash

curl -s -A "Agent Gerald" http://web.bcactf.com:49156/ -o flag.txt
strings flag.txt | grep "bcactf{"
rm flag.txt
