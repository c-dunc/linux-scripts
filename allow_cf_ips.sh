#!/bin/bash

# Cloudflare API endpoint for IP ranges
API_URL="https://api.cloudflare.com/client/v4/ips"

# Fetch the IP ranges from the API
echo "Fetching Cloudflare IP ranges..."
response=$(curl -s $API_URL)

ipv4_ranges=$(echo "$response" | jq -r '.result.ipv4_cidrs[]')
ipv6_ranges=$(echo "$response" | jq -r '.result.ipv6_cidrs[]')

ports=(80 443)

echo "Removing existing UFW rules for Cloudflare..."
sudo ufw delete allow proto tcp from any to any port 80 comment 'Cloudflare IP'
sudo ufw delete allow proto tcp from any to any port 443 comment 'Cloudflare IP'

# Add rules for IPv4 ranges
echo "Adding UFW rules for Cloudflare IPv4 ranges..."
for ip in $ipv4_ranges; do
    for port in "${ports[@]}"; do
        sudo ufw allow proto tcp from "$ip" to any port "$port" comment 'Cloudflare IP'
    done
done

# Add rules for IPv6 ranges
echo "Adding UFW rules for Cloudflare IPv6 ranges..."
for ip in $ipv6_ranges; do
    for port in "${ports[@]}"; do
        sudo ufw allow proto tcp from "$ip" to any port "$port" comment 'Cloudflare IP'
    done
done

sudo ufw enable

echo "Cloudflare UFW rules updated successfully."