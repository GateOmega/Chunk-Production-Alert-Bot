# Chunk Production Alert Bot for Near Validators

This script was created for Near Validators to check chunk uptimes and get alerts to telegram channels for under certain threshold.

## Contents

1. Creating a Shell Script.
2. Variables / Requirements.
3. [Creating Telegram Bot](https://github.com/GateOmega/Chunk-Production-Alert-Bot/blob/main/Telegram-Bot.md). 
4. Make your script Executable
5. Testing Script and Outputs
6. Automation — Crontab.

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

echo "---" >> /full-path-to/uptimelogs/all.log
date >> /full-path-to/uptimelogs/all.log
echo $CURRENT >> /full-path-to/uptimelogs/all.log

```
To save the file: CTRL + O and press Enter.  
To exit from file: CTRL + X.  
You can edit/change variables later if you like.

Create uptimelogs directory to see all chunk production history. If you need custom paths, edit your uptime-alert.sh. Update the log-file-location with the path to the log file.
```
mkdir $HOME/uptimelogs 
```

## 2. Variables / Requirements

$THRESHOLD VALUE.  
Replace THRESHOLD value with the threshold value of your choice.   
THRESHOLD=90 (the threshold value of your choice).  
  
$VALIDATOR-NAME.  
Replace with your Near Validator name to grep.   

$YOUR-TELEGRAM-CHAT-ID - Please see [How to find Telegram Chat ID?](https://github.com/GateOmega/Chunk-Production-Alert-Bot/blob/main/Telegram-Bot.md)     
Replace <YOUR TELEGRAM CHAT ID> section with your channel ID (prefix -100)  
Example : -1001567031322   

$Telegram Bot ID - Please see [How to find Telegram Bot Token?](https://github.com/GateOmega/Chunk-Production-Alert-Bot/blob/main/Telegram-Bot.md)    
Replace <YOUR-TELEGRAM-BOT-TOKEN> section with your bot token ID (prefix bot)  
Example : bot5497182788:AAGXS-nArOMZaER_6xqfeOLW-VD-frlSfDM  

## 3. Creating Telegram Bot 

If you know your bot token and chat Id you can pass this section. Otherwise please see [Creating Telegram Bot](https://github.com/GateOmega/Chunk-Production-Alert-Bot/blob/main/Telegram-Bot.md)

## 4. Make your Script Executable

Run below command to make your script executable

```
chmod + x $HOME/uptime-alert.sh
```

## 5. Testing Script and Outputs

After making your script executable try below command if the script works and sends alerts your telegram channel.   

```
./uptime-alert.sh
```
You will be seeing output like these:   

Shell Output:   
```
{"ok":true,"result":{"message_id":299488,"sender_chat":{"id":-1001567031322,"title":"Server-Alerts-GateOmega","type":"channel"},"chat":{"id":-1001567031322,"title":"Server-Alerts-GateOmega","type":"channel"},"date":1661013688,"text":"Chunk Uptime Check:  95      %"}}
```
Telegram messages like:   

![Telegram_alerts](https://github.com/GateOmega/Chunk-Production-Alert-Bot/blob/main/images/telegram_alerts.png)

## 6. Automation - Crontab

You may want to run this script hourly or in specific periods you need. So you need to create a cron job for it.   

To check if cron is installed in your system, run the following command.
```
dpkg -l cron
```
If cron is not installed, install the cron package on Ubuntu:
```
apt-get install cron
```
Open the crontab file with the following command.
```
crontab -e
```
If you run this command for the first time in your system or server, you may have the following output. Then, choose 1 to continue.   

![Crontab](https://github.com/GateOmega/Chunk-Production-Alert-Bot/blob/main/images/crontab.png)  

Add the following line to the end in the crontab file to run uptime-alert script in every 2 hours.  

```  
0 */2 * * * sh $HOME/./uptime-alert.sh
```  
To save the file: CTRL + O and press Enter.  
To exit from file: CTRL + X.  

To understand crontab timing strings check [CrontabGuru](https://crontab.guru)
