#!/bin/bash

CURRENT=$(near validators current |grep <VALIDATOR-NAME> | awk -F'|' '{ print $5}'  | sed 's/%//g')
THRESHOLD=90

MESSAGE="Chunk Uptime Check: $CURRENT%"


if [ "$CURRENT" -lt "$THRESHOLD" ] ; then
curl -X POST \
-H 'Content-Type: application/json' \
-d '{"chat_id": "<YOUR-TELEGRAM-CHAT-ID>", "text": "'"$MESSAGE"'", "disable_notification": true}' \
https://api.telegram.org/<YOUR-TELEGRAM-BOT-TOKEN>/sendMessage
fi


echo "---" >> /home/<$USER>/uptimelogs/all.log
date >> /home/<$USER>/uptimelogs/all.log
echo $CURRENT >> /home/<$USER>/uptimelogs/all.log
