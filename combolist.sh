#!/bin/bash
set -euo pipefail

if [ $# -ne 2 ]; then
    echo -e "\r\n\tSyntax: $0 <usernames.txt> <passwords.txt>\r\n" >&2
    exit 1
fi

user_file="$1"
pass_file="$2"

for file in "$user_file" "$pass_file"; do
    if [ ! -f "$file" ]; then
        echo -e "\r\n\tError! File $file not found/unavailable.\r\n" >&2
        exit 1
    fi
done

output_file="combolist_$(date +"%Y%m%d_%H%M%S").txt"

while IFS= read -r user || [ -n "$user" ]; do
    user="${user//[[:space:]]/}"
    [ -z "$user" ] && continue

    while IFS= read -r pass || [ -n "$pass" ]; do
        pass="${pass//[[:space:]]/}"
        [ -z "$pass" ] && continue
        
        echo "${user}:${pass}"
        
    done < "$pass_file"

done < "$user_file" > "$output_file"
