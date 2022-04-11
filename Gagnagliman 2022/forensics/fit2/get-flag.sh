#!/bin/bash

# unzip challenge
unzip -q fit2.zip
cd repo/

# Revert current patch and decrypt the flag
git apply -R .diff
chmod +x main.py
python3 main.py

# Cleanup
cd ..
rm -rf repo/
