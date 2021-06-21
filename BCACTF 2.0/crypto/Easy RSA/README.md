![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/crypto/Easy%20RSA/Challenge.png)


The file given contains `p,q,n,e` which is everything we need to decrypt an RSA cipher.

```python
#!/usr/bin/env python3

from Crypto.Util.number import long_to_bytes

p = 251867251891350186672194341006245222227 # Prime number 1
q = 31930326592276723738691137862727489059 # Prime number 2
n = 8042203610790038807880567941309789150434698028856480378667442108515166114393
e = 65537
ct = 5247423021825776603604142516096226410262448370078349840555269847582407192135

phi = (p-1)*(q-1) # Euler's Totient
d = pow(e, -1, phi) # Private Key

print(long_to_bytes(pow(ct, d, n)).decode()) # Flag

#FLAG: bcactf{RSA_IS_EASY_AFTER_ALL}
```
