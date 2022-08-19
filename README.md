# Near-Chunk-Uptime-Check

This script was created for Near Validators to check chunk uptimes and get alerts to telegram channels for certain threshold.

[About Telegram Bot ](https://core.telegram.org/bots)

### Create sh file 

Open your shell and create a script file with the below command.

```
nano $HOME/uptime-alert.sh
```

Add the following script into this file.

```
#!/bin/bash

CURRENT=$(near validators current |grep <VALIDATOR-NAME> | awk -F'|' '{ print $5}' | sed 's/%//g')
THRESHOLD=90

MESSAGE="Chunk Uptime Check: $CURRENT%"


if [ "$CURRENT" -lt "$THRESHOLD" ] ; then
curl -X POST \
-H 'Content-Type: application/json' \
-d '{"chat_id": "<YOUR-TELEGRAM-CHAT-ID>", "text": "'"$MESSAGE"'", "disable_notification": true}' \
https://api.telegram.org/<YOUR-TELEGRAM-BOT-TOKEN>/sendMessage
fi

#export NEAR_ENV=shardnet
#export LOGS=/home/$USER/uptimelogs

echo "---" >> /home/<$USER>/uptimelogs/all.log
date >> /home/<$USER>/uptimelogs/all.log
echo $CURRENT >> /home/<$USER>/uptimelogs/all.log

```
To save the file: CTRL + O and press Enter
To exit from file: CTRL + X


# Variables and Requirements

$Threshold
Replace THRESHOLD value with the threshold value of your choice.
THRESHOLD=90(the threshold value of your choice)

$Telegram Chat ID
Replace <YOUR TELEGRAM CHAT ID> section with your channel ID with prefix -100
Example : -1001567031322 

$Telegram Bot ID
Replace <YOUR TELEGRAM BOT ID> section with your bot ID with prefix bot
Example : bot5497182788:AAGXS-nArOMZaER_6xqfeOLW-VD-frlSfDM

$USER
Replace your with your user
  
$VALIDATOR-NAME
Replace with your Near Validator name to grep.
  
