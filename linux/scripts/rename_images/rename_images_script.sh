#!/bin/bash

# SCRIPT TO RENAME ALL FOLDER IMAGES WITH .JPG OR .PNG EXTENSION AND ASSIGN IT A NEW COUNTER NAME

# EXECUTE WITH --> BASH <script.sh>

counter=0
basename="product_"

for picture in `ls -v *.jpg *.png`
do
   counter=$(($counter+1))
   newname=$basename$counter

   if [[ $picture == *"jpg"* ]]; then
      echo "Renaming... $picture.jpg to $newname.jpg"
      mv $picture $newname.jpg

   elif [[ $picture == *"png"* ]]; then
      echo "Renaming... $picture.png $newname.jpg"
      mv $picture $newname.png
   fi
done
