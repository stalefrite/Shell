#!/bin/bash

if ! command -v curl &> /dev/null; then
    echo -e "\r\n\tError: Utility CURL not found/missing.\r\n"
    exit 1
fi

if [ -z "$1" ]; then
    echo -e "\r\n\tSyntax: $0 <youtube_video_url>\r\n"
    exit 1
fi

id="null"
regex="(v=|shorts\/)([a-zA-Z0-9_-]{11})"

if [[ $1 =~ $regex ]]; then
    id="${BASH_REMATCH[2]}"
else
    echo -e "\r\nInvalid URL\r\n"
    exit 1
fi

file_names=(
    "maxresdefault.jpg"
    "hqdefault.jpg"
    "default.jpg"
)

for file_name in "${file_names[@]}"; do
    url="https://i.ytimg.com/vi/$id/$file_name"

    if curl -sS -L -f "$url" -o "$file_name"; then
        echo -e "\tSaved: $file_name"
    fi
done
