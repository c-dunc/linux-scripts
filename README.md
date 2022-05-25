
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
  *Note: This has been tested and created for AlmaLinux. To change this you can change the `ip_list` variable to make it run on different linux flavours!*
   
  
# Credits
[ETMRidge](https://github.com/ETMRidge) ~ Script ideas
