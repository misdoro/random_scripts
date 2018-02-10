#!/bin/bash

PDF=$1

pdftohtml -nodrm -i -s -xml $PDF
XML=`ls -tr *.xml | tail -n1`
echo $XML

grep ' width="763" height="9" font="5">' $XML | sed -e 's/<[^>]*>//g'  > $XML.txt

cat $XML.txt | 
  sed -r 's/^(.{5})/\1,:/' | # Date
  sed -r 's/([^:]*):.(.{2}).0*([0-9]+).(.{3})/\1\2\3\4,:/' | #Numero
  sed -r 's/([^:]*):.{13}(.{22})/\1"\2",:/' | # Nom Prenom
  sed -r 's/([^:]*):[^0-9]*([0-9]+),([0-9]+).(.).{14}/\1\2.\3,\4,:/' | # Poids v
  sed -r 's/([^:]*):[^0-9]*([0-9]+),([0-9]+).(.).*/\1\2.\3,\4,/' > $XML.csv # Tax A

less $XML.csv
