#!/bin/bash

curl -s http://web.bcactf.com:49157/code.wasm -o code.wasm
strings code.wasm | grep "bcactf{"
rm code.wasm
