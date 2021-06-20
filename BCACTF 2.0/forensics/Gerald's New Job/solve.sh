#!/bin/bash

binwalk -eq gerald.pdf
xdg-open _gerald.pdf.extracted/GeraldFlag.png
echo "bcactf{g3ra1d_15_a_ma5ter_p01yg1ot_0769348}"
