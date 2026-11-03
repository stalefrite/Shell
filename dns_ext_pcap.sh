#!/bin/bash

# Extract DNS entries from Wireshark Packet Capture

if ! command -v tshark &> /dev/null; then
    echo -e "\r\n\tError! Utility tshark is not installed/missing.\r\n" >&2
    exit 1
fi

if [ "$#" -ne 1 ]; then
    echo -e "\r\n\tSyntax: $(basename "$0") <path_to_pcap>\r\n" >&2
    exit 1
fi

pcap_path="$1"

if [ ! -f "$pcap_path" ]; then
    echo -e "\r\n\tError! File does not exist or is not a regular file.\r\n" >&2
    exit 1
fi

if [[ ! "$pcap_path" =~ \.(pcap|pcapng)$ ]]; then
    echo -e "\r\n\tError! Invalid file extension.\r\n" >&2
    exit 1
fi

log_file="tshark_$(date +%Y%m%d_%H%M%S).txt"

echo -e "\r\n\tExtracting DNS fields and saving to $log_file...\r\n"

tshark -r "$pcap_path" \
       -Y "dns" \
       -T fields \
       -e ip.src \
       -e dns.qry.name \
       -e dns.a \
       -E header=y \
       -E separator=, > "$log_file"

exit 0
