![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/misc/Welcome%20to%20the%20Casino/challenge.png)

```python
#!/usr/bin/env python3

# FLAG: bcactf{y0u_g0t_1ucKy_af23dd97g64n}

from pwn import *

def send_letter():
    global r
    r = remote('misc.bcactf.com', 49156)
    r.recvuntil('"')
    lever_letter = r.recv().decode()[0]
    r.sendline(bytes(lever_letter, encoding='latin-1'))
    r.recvline()
send_letter()

while True:
    try:
        flag = r.recvline()
        if b"bcactf{" in flag:
            print(log.success(flag))
            break
    except EOFError:
        print(log.info("EOF Reached"))
        send_letter()
```

Running the script in multiple terminals or Tmux panes
will eventually lead to a three-of-a-kind on the slot machine
and give out the flag.
