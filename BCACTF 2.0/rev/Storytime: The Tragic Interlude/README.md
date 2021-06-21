![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/rev/Storytime:%20The%20Tragic%20Interlude/challenge.png)

<br>

### Reversing with Ghidra

![Decompile](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/rev/Storytime:%20The%20Tragic%20Interlude/Decompiled.png)

Looking at the binary in ghidra we see on **line 174** that `local_598` is assigned the address of `local_38`.

<br>

### Debugging with GDB

Now in gdb we can take a look at what is stored at the address of the variable.
With the commands below we get the flag for the challenge.

- Run the binary
- Place a breakpoint on this instruction `0x00005555555555b8 <+980>:   mov    DWORD PTR [rbp-0x718],0x0`
- examine the RAX register `x/s $rax`

![GDB](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/rev/Storytime:%20The%20Tragic%20Interlude/GDB.png)

<br>

### Automated
```python
#!/usr/bin/env python3

from pwn import *

p = process('./story2')
gdb.attach(p, '''
        r
        b *main+980
        r
        x/s $rax
''')
p.interactive()

#FLAG: bcactf{th4t_0th3r_dr4g0n_76fw8kc1lav}
```
