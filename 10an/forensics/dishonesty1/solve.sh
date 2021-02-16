#!/usr/bin/bash

CURRENT_DIR=$(pwd)
binwalk -eq ${CURRENT_DIR}/totally-my-report.docx

echo -n "[+] FLAG: "
cat "${CURRENT_DIR}/_totally-my-report.docx.extracted/docProps/core.xml" | grep -o 10an{'.*'}

# Clean up

rm -rf "${CURRENT_DIR}/_totally-my-report.docx.extracted"
