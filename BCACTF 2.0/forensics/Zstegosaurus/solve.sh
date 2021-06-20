#!/bin/bash

if [[ $1 -eq 0 ]]; then
  echo "[!] Usage: ./solve <filename>"
else
  echo ""
  flag=$(zsteg $1 | grep -ioP "h15.{17}")
  echo "bcactf{$flag}"
  echo ""
fi
