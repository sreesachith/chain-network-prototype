#!/bin/bash

for file in *.sh
do
  #cmd [option] "$file" >> results.out
  sed -i -e 's/\r$//' $file
  echo $file
done