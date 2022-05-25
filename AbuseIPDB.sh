#!/bin/bash

API_KEY="APIKey"

ip_list=( $( cat /var/log/httpd/access_log | awk '{print $1}' | uniq | sort -n | sort -nr ) ) #Get all Apache IP addresses and organise

echo
echo "Format:"
echo "IP, Abuse confidence, Country"
echo

{
for ip in "${ip_list[@]}"; do

json_req_data=$(curl -G https://api.abuseipdb.com/api/v2/check \
        --data-urlencode """ipAddress=$ip""" \
        -d verbose \
        -H "Key: $API_KEY" \
        -H "Accept: application/json" 2>/dev/null | jq .)

abuseConfidenceScore=$(echo $json_req_data | jq -r '.data.abuseConfidenceScore')
countryName=$(echo $json_req_data | jq -r '.data.countryName')

if [ "$abuseConfidenceScore" -ge 1 ]; then
echo "$ip $abuseConfidenceScore '$countryName'"
fi

done
} | tee output.txt

echo
echo "Total potentially malicious IP's : $( (cat output.txt | wc -l ) )"
echo "Log file             : output.txt"
