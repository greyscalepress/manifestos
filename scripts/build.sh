#!/bin/bash

## Purpose of this script

## Select all files in the folder /content/fr
## Save them to the folder /temp/

## 1: We declare some variables

INPUT="../content/intro.txt ../content/manifestos/*.txt"
TEMP="../temp/newfile.txt"
TEMP2="../temp/newfile2.txt"
OUTPUT="../output/output.pdf"

## 2: AWK Method

## FNR = the current record number in the current file.
## NR = "Number of Lines seen so far in the current file"

## \\vfill \\columnbreak \\newpage

awk '
BEGIN {
  start = ""; ## \\begin{multicols}{2}
  end = "\\newpage"; ## \\end{multicols}\n
  print start
}
FNR == 1 && FNR != NR {
  print end;
  print start
}
{print} ## {print $0,"  "} ## Adds two spaces after each end-of-line, to keep line returns in Markdown.
END {
  print end
}
' $INPUT > $TEMP


## awk '{print $0,"  x"}' $TEMP > $TEMP2
## mv $TEMP2 $TEMP

## PANDOC processing

## Consolata
## Inconsesi

pandoc -f markdown -o $OUTPUT --template=../templates/custom $TEMP --latex-engine=xelatex --variable mainfont=Consolata --variable sansfont=Futura --variable monofont=Inconsesi --variable fontsize=9pt --toc --toc-depth=1

## End of file
