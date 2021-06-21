![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/web/Wasm%20Protected%20Site%201/challenge.png)

Taking a look a the network tab within developer tools
reveals a **GET** request to a `code.wasm` file.

Going to the path `web.bcactf.com:49157/code.wasm`
prompts us with a download of the file.

running strings and grepping for the flag format
on the downloaded file gives us the flag.

```bash
#!/bin/bash

curl -s http://web.bcactf.com:49157/code.wasm -o code.wasm
strings code.wasm | grep "bcactf{"
rm code.wasm

# bcactf{w4sm-m4g1c-xRz5}
```
