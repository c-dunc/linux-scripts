
# Linux scripts

Scripts to use on Linux servers ~ Will constantly be adding new ones!



## Monitoring.sh
- Monitoring servers to see if they are online/offline.
- If the server is offline it will send a notification via discord webhook
- To use, simply add your server IP-addresses to the list `ips` add your discord webhook to `WEBHOOK_URL` and discord user ID to `discord_user_ID`
- It is recommended to set up a [crontabs job.](https://www.howtogeek.com/101288/how-to-schedule-tasks-on-linux-an-introduction-to-crontab-files/)
![Monitoring](/img/monitoring.png)

*Tested on AlmaLinux 8.5 (Arctic Sphynx)*

# AbuseIPDB.sh
 - Quickly scan a number of IPs on [AbuseIPDB.](https://www.abuseipdb.com/)
 - Searches for any IPs in a file via regex and sorts for duplicates, etc
 - to use do `./AbuseIPDB.sh` and the script will automatically pull IP-Addresses from the httpd logfile.
 - Saves in a format that makes it easy for awk `output.txt`
 - Enter API Key in `API-KEY` variable and run script! 
 One line install : 
 
 `wget https://raw.githubusercontent.com/csduncan06/linux-scripts/main/AbuseIPDB.sh && chmod 755 AbuseIPDB.sh && ./AbuseIPDB.sh` ;)
 
  *Note: This has been tested and created for AlmaLinux. To change this you can change the `ip_list` variable to make it run on different linux flavours!*
   
## allow_cf_ips.sh
 - Gets a list of both IPv4 and IPv6 IP addresses from cloudflare
 - Removes existing rules for web port connectivity
 - Allows each IP on port 80 and 443. 
 - Ensures that all web requests are proxied through CloudFlare. 
![cf-log](/img/cf-log.png) 
![cf-rule](/img/cf-rule.png)

## hugo-assist.sh
 - CLI tool to help the deployment of posts with hugo!
 
![hugo-assist](/img/hugo-assist.png) 

## S3-Backup.sh
 - Simple & Lightweight script for backing directories up into AWS S3. 
 ![S3-Backup](/img/S3-Backup.png) 


# Credits
[ETMRidge](https://github.com/ETMRidge) ~ Script ideas
