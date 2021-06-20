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
