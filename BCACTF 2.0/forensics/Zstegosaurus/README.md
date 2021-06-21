![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/forensics/Zstegosaurus/challenge.png)

The name of the png image file is a reference to a famous
Steganography tool called `Zsteg`. Installing and running Zsteg
on the file gives out the flag

```bash
root@kali:~/BCACTF_2.0/forensics/Zstegosaurus$ zsteg zstegosaurus.png
b1,r,lsb,xy         .. text: "h15_n@m3_i5nt_g3rard"
b4,rgb,msb,xy       .. text: ["w" repeated 10 times]
```

**FLAG: bcactf{h15_n@m3_i5nt_g3rard}**
<br>
<br>

## Automated

```bash
#!/bin/bash

if [[ $1 -eq 0 ]]; then
  echo "[!] Usage: ./solve <filename>"
else
  echo ""
  flag=$(zsteg $1 | grep -ioP "h15.{17}")
  echo "bcactf{$flag}"
  echo ""
fi
```
