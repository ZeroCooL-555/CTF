#!/bin/bash
b64reved=`cat kringle-crush.txt`
realb64=`echo "$b64reved" | rev`
echo "$realb64" | base64 -d
