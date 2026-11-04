#!/bin/bash

if [ $# -lt 1 ]; then
    echo -e "\r\n\tSyntax: $0 <reflector_list>\r\n" >&2
    exit 1
fi

list="$1"

output="alive_$(date +%H%M%S_%Y%m%d).txt"

if [ ! -f "$list" ]; then
    echo "\r\n\tError! File '$list' does not exist.\r\n" >&2
    exit 1
fi

# generic placeholder
domain="example.com"

while IFS= read -r ip || [ -n "$ip" ]; do
    # remove whitespace
    ip=$(echo "$ip" | xargs)

    # skip empty lines or comments
    if [ -z "$ip" ] || [[ "$ip" == \#* ]]; then
        continue
    fi

    result=$(dig +short +timeout=1 +tries=1 @"$ip" "$domain" A 2>/dev/null)
    
    if [ -n "$result" ]; then
        #resolved_ips=$(echo "$result" | xargs)
        
        echo -e "[+] Success: $ip"
        echo "$ip:53" >> $output 2>/dev/null
    else
        echo -e "[-] Failure: $ip"
    fi

    #sleep 0.02

done < "$list"

