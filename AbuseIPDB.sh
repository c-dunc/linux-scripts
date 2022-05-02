API_KEY="AbuseIPDB-API-KEY"

clear
if [ "$1" == "" ]
then
echo "[!] Please enter a filepath that contains IP-Addresses"
fi

echo "| AbuseIPDB quickscan at $(date)" > output.txt

ip_list=( $(cat $1 | grep -o "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" | sort -u) )
pot_mal_ip_count=0

for ip in "${ip_list[@]}"; do
json_req_data=$(curl -G https://api.abuseipdb.com/api/v2/check \
        --data-urlencode """ipAddress=$ip""" \
        -d verbose \
        -H "Key: $API_KEY" \
        -H "Accept: application/json" 2>/dev/null | jq .)

abuseConfidenceScore=$(echo $json_req_data | jq -r '.data.abuseConfidenceScore')
usageType=$(echo $json_req_data | jq -r '.data.usageType')
countryName=$(echo $json_req_data | jq -r '.data.countryName')

if [ "$abuseConfidenceScore" -ge 1 ]; then
pot_mal_ip_count=$((pot_mal_ip_count+1))
fi


echo "checking IP-Address: $ip
Abuse confidence : $abuseConfidenceScore %
Country: $countryName
Usage: $usageType
" >> output.txt
done


echo "Total number of IP-Addresses:"
echo "$(wc -l $1 | awk '{ print $1 }')"
echo
echo "Total number of potentially malicious IP-Addresses:"
echo $pot_mal_ip_count
echo
echo "Log can be found in 'output.txt' "
