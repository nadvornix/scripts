#!/bin/bash

# source: https://stackoverflow.com/questions/9820830/how-can-i-merge-pdf-files-or-ps-if-not-possible-such-that-every-file-will-begi
# joins multiple pdfs so that each new file starts at odd number so that you can easily print then all doublesided.

for f in *.pdf; do
  let npages=$(pdfinfo "$f"|grep 'Pages:'|awk '{print $2}')
  echo $npages;
  let modulo="($npages %2)"
  if [ $modulo -eq 1 ]; then
    pdftk "$f" "/home/jiri/Downloads/blank.pdf" output "aligned_$f"
  else
    cp "$f" "aligned_$f"
  fi
done
pdftk aligned_*.pdf output all.pdf
rm aligned_*
