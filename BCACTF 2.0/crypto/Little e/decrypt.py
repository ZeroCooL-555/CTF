#!/usr/bin/env python3

# https://github.com/shiltemann/CTF-writeups-public/tree/master/PicoCTF_2018#cryptography-250-safe-rsa

import gmpy2
from Crypto.Util.number import long_to_bytes

ct = 1112413624683819960899152482895461211039349964898672381675850025556800617245120168928400758297834676330400246617472191750627367991315450127361583383350639760738254818244740474313061192563860605923503717
e = 3
gmpy2.get_context().precision=200000
m = gmpy2.root(ct,e)
print(long_to_bytes(m).decode())

