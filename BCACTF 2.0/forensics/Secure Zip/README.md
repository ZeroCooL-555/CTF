![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/forensics/Secure%20Zip/challenge.png)

we are given a ZIP file which is password protected
and we have to obtain the password to be able
to unzip and retrieve the flag.

Because this is a ZIP file we have a great tool to help us
get the job done, `fcrackzip` is a free/fast Zip Password Cracker 
which searches each zipfile given for encrypted files and tries to guess the password.

After reading through the man page for the tool
we can build out a command that looks like this

`fcrackzip -D -p /usr/share/wordlists/rockyou.txt* -v -u chall.zip`

After letting this run for sometime we get the password **dogedoge**.
Unzipping with the password we can cat the file `flag.txt`

**FLAG: bcactf{cr4ck1ng_z1p_p455w0rd5_15_fun_a12ca37bdacef7}**
<br>
<br>

## Automated
```bash
#!/bin/bash

password=$(fcrackzip -D -p /usr/share/wordlists/rockyou.txt -v -u chall.zip | grep -ioP "==.{0,10}" | sed 's/==//')
unzip -q -P $password chall.zip
cat flag.txt
echo "" 
rm flag.txt
rm homework.txt
```
