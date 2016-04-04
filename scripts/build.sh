#!/bin/bash

## Purpose of this script

## Select all files in the folder /content/fr
## Save them to the folder /temp/

## 1: We declare some variables

INPUT="../content/meta.txt ../content/manifestos/*.*" ## ../content/intro.txt 
TEMP="../temp/newfile.txt"
TEMP2="../temp/newfile2.txt"

TIMESTAMP=$(date +"%s")
OUTPUT="../output/output-"$TIMESTAMP".pdf"


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
## "Breite Grotesk"
## "Work Sans"
## "Archivo Narrow"
## "Sophia Nubian"
## "Limousine" - by OSP Foundry
## Monoid - by Andreas Larsen
## HK Grotesk - by Alfredo Marco Pradil, Hanken Design Co.

pandoc -f markdown -o $OUTPUT --template=../templates/customV2 $TEMP --latex-engine=xelatex \
    --variable mainfont="Roboto" \
    --variable boldfont="Roboto Bold" \
    --variable italicfont="Roboto Italic" \
    --variable bolditalicfont="Roboto Bold Italic" \
    --variable sansfont=Futura \
    --variable monofont=Inconsesi \
    --variable fontsize=9pt \
    --variable urlcolor=black \
    --variable linkcolor=black \
    --variable documentclass=book \
    --toc --toc-depth=1 \
    --include-before-body=../content/intro.txt

## End of file
