#!/usr/bin/python3

from subprocess import run, PIPE
from base64 import b32decode


# Some vars

QR_Letters = []
zip_name = "ezgif-2-74aff622fa-gif-im.zip"



# unzip GIF frames
run(["unzip", "-q", zip_name])




# Use zbarimg on each image

for i in range(80):
    num = str(i).zfill(2)
    filename = f"frame_{num}_delay-0.04s.gif"
    letter = run(["zbarimg", filename], capture_output=True, text=True, stdin=PIPE)
    QR_Letters.append(letter.stdout)




# Remove empty strings in list, decode base32 and print flag

QR_Letters = [x.strip()[8::] for x in QR_Letters if x]
base32_string = ''.join(QR_Letters)
print("[+] FLAG:", b32decode(base32_string).decode('latin-1'))



# Cleanup

for i in range(80):
    num = str(i).zfill(2)
    filename = f"frame_{num}_delay-0.04s.gif"
    run(["rm", filename])
