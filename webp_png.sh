#!/bin/bash
# Convert WEBP images to PNG format for easy viewing
clear

type dwebp >/dev/null 2>&1 || { 
    echo -e "\r\n\tError! Dependency not found: dwebp\r\n"
    exit 1
}

# iterale through all WEBP files in directory
for file in *.webp; do

  # silently do-nothing if no files are found
  if [ -f "$file" ]; then

    # swap file extension to PNG
    output="${file%.webp}.png"
    
    # use utility to handle the conversions
    dwebp "$file" -o "$output"
    
    echo "---> Converted $file to $output"
  fi
done
