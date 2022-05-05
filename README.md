
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
 - to use do `./AbuseIPDB.sh <path-to-ips-file>`
 - Saves to `output.txt` to make it easier for notes

  *Tested on AlmaLinux 8.5 (Arctic Sphynx)*
  
  
# Credits
[ETMRidge](https://github.com/ETMRidge) ~ Script ideas
