
# Linux scripts

Scripts to use on Linux servers



## Monitoring.sh
- Monitoring servers to see if they are online/offline.
- If the server is offline it will send a notification via discord webhook
- To use, simply add your server IP-addresses to the list `ips` add your discord webhook to `WEBHOOK_URL` and discord user ID to `discord_user_ID`
- It is recommended to set up a [crontabs job.](https://www.howtogeek.com/101288/how-to-schedule-tasks-on-linux-an-introduction-to-crontab-files/)
![Monitoring](/img/monitoring.png)
*Tested on AlmaLinux release 8.5 (Arctic Sphynx)*
