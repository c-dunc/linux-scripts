ips=(
1.1.1.1
)

export WEBHOOK_URL="DISCORD WEBHOOK HERE" #discord webhook to send to
discord_user_ID="780905552381214780" #discord user ID to server mention in discord



for x in "${ips[@]}"; do
ping -c 1 $x &> /dev/null

if [[ $? -eq 1 ]]; then

curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \":bell: Hey <@$discord_user_ID> IP: $x is  :x:OFFLINE:x: at $(date)  :bell:\"}" $WEBHOOK_URL
else
  echo "$x is online!"

fi
done
