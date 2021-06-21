![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/forensics/Gerald's%20New%20Job/challenge.png)

After having looked at the pdf document there seems to be
nothing wrong until you look for hidden/embedded files.
By using `Binwalk` on the document to look for embedded files
we get interesting embedded files

```bash
DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             PDF document, version: "1.3"
66            0x42            Zip archive data, at least v2.0 to extract, uncompressed size: 441011, name: GeraldFlag.png
390777        0x5F679         Zip archive data, at least v2.0 to extract, uncompressed size: 367, name: __MACOSX/._GeraldFlag.png
391327        0x5F89F         End of Zip archive, footer length: 22
392072        0x5FB88         Zlib compressed data, default compression
722826        0xB078A         Zlib compressed data, default compression
723219        0xB0913         End of Zip archive, footer length: 22
```

Extracting the hidden contents with `binwalk -e gerald.pdf` and opening `Gerald.png`
reveals the flag

<img width=408 height=331 src="https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/forensics/Gerald's%20New%20Job/flag.png">

**FLAG: bcactf{g3ra1d_15_a_ma5ter_p01yg1ot_0769348}**
