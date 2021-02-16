#!/usr/bin/bash

echo "[+] Unzipping 'git.zip' & changing dir to '/src/.git'"
unzip -q git.zip
cd "$(pwd)/src/.git"

CURRENT_DIR=$(pwd)

echo "[+] See The commit log for interesting things"
git --work-tree="${CURRENT_DIR}" log

echo "[+] Investigating 'Message' commit"
git --work-tree="${CURRENT_DIR}" cat-file -p 494525b5e001d51976571a614dc01e3229751322

echo "[+] Investigating tree hash"
git --work-tree="${CURRENT_DIR}" cat-file -p 8631b51161b51098226aa24ce208bea69098f10c

echo "[+] Investigating 'flag.txt'"
git --work-tree="${CURRENT_DIR}" cat-file -p 39896a48b60a2488b8d9f06f415288bacfc0e0cf

echo "[+] Removing 'src/'"
cd ../../ && rm -rf src/
