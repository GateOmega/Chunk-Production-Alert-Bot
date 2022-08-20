# Chunk Production Alert Bot for Near Validators

This script was created for Near Validators to check chunk uptimes and get alerts to telegram channels for certain threshold.

## Contents

1. Creating a Shell Script.
2. Variables / Requirements.
3. [Creating Telegram Bot](https://github.com/GateOmega/Chunk-Production-Alert-Bot/blob/main/Telegram-Bot.md). 
4. Make your script Executable
5. Automation — Crontab.

## 1. Creating Shell Script

Open your shell and create a script file with the below command.

```
nano $HOME/uptime-alert.sh
```

Add the following script into this file. [uptime-alert.sh](https://github.com/GateOmega/Chunk-Production-Alert-Bot/blob/main/uptime-alert.sh)

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
#export LOGS= /full-path-to/uptimelogs

echo "---" >> /full-path-to/uptimelogs/all.log
date >> /full-path-to/uptimelogs/all.log
echo $CURRENT >> /full-path-to/uptimelogs/all.log

```
Create uptimelogs directory to see all chunk production history. If you need custom paths, edit your uptime-alert.sh. Update the log-file-location with the path to the log file.
```
mkdir $HOME/uptimelogs 
```
To save the file: CTRL + O and press Enter.  
To exit from file: CTRL + X.  
You can edit/change variables later if you like.

## 2. Variables / Requirements

$THRESHOLD VALUE.  
Replace THRESHOLD value with the threshold value of your choice.   
THRESHOLD=90 (the threshold value of your choice).  
  
$VALIDATOR-NAME.  
Replace with your Near Validator name to grep.   

$YOUR-TELEGRAM-CHAT-ID - Please see [How to find Telegram Chat ID?](https://github.com/GateOmega/Chunk-Production-Alert-Bot/blob/main/Telegram-Bot.md).     
Replace <YOUR TELEGRAM CHAT ID> section with your channel ID with prefix -100  
Example : -1001567031322   

$Telegram Bot ID - Please see [How to find Telegram Bot Toke?](https://github.com/GateOmega/Chunk-Production-Alert-Bot/blob/main/Telegram-Bot.md).    
Replace <YOUR-TELEGRAM-BOT-TOKEN> section with your bot ID with prefix bot.  
Example : bot5497182788:AAGXS-nArOMZaER_6xqfeOLW-VD-frlSfDM  

## 3. Creating Telegram Bot 

If you know your bot token and chat Id you can pass this section. Otherwise please see [Creating Telegram Bot](https://github.com/GateOmega/Chunk-Production-Alert-Bot/blob/main/Telegram-Bot.md)

## 4. Make your Script Executable

Run below command to make your script executable

```
chmod + x $HOME/disk-space-check.sh
```
## 5. Automation - Crontab

