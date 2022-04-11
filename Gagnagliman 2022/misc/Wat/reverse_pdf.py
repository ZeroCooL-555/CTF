#!/usr/bin/python3

with open('wat', 'rb') as f:
    data = f.read()

with open('rev.pdf', 'wb') as f:
    f.write(data[::-1])
