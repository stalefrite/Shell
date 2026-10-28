#!/bin/bash

# Define the path to the .txt file containing the URLs
url_file="links.txt"

# Read each URL from the .txt file and process it
while IFS= read -r url; do
    # Use curl to download the file, silently (-s), and check if it succeeds
    curl -s -O "$url"
    
    echo "[+] Downloading: $url"
    
    
    # Check if curl was successful
    if [ $? -ne 0 ]; then
        echo "[-] Error: $url"
    fi
    
    # Pause for 0.5 seconds between downloads
    sleep 0.5
done < "$url_file"
