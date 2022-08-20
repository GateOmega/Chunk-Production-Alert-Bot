# Chunk Production Alert Bot for Near Validators

This script was created for Near Validators to check chunk uptimes and get alerts to telegram channels for certain threshold.

## Contents

1. Creating a Shell Script.
2. Variables / Requirements
3. Creating Telegram Bot 
4. Adding variables to the script.
5. Automation — Crontab.

## 1. Creating Shell Script

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
#export LOGS= /full-path-to/uptimelogs

echo "---" >> /full-path-to/uptimelogs/all.log
date >> /full-path-to/uptimelogs/all.log
echo $CURRENT >> /full-path-to/uptimelogs/all.log

```
To save the file: CTRL + O and press Enter.  
To exit from file: CTRL + X. 


## 2. Variables / Requirements


$THRESHOLD VALUE.  
Replace THRESHOLD value with the threshold value of your choice.   
THRESHOLD=90 (the threshold value of your choice).  
  
$VALIDATOR-NAME.  
Replace with your Near Validator name to grep.   

$YOUR-TELEGRAM-CHAT-ID - Please see  Creating Telegram Bot.   
Replace <YOUR TELEGRAM CHAT ID> section with your channel ID with prefix -100  
Example : -1001567031322   

$Telegram Bot ID - Please see Creating Telegram Bot.   
Replace <YOUR TELEGRAM BOT ID> section with your bot ID with prefix bot.  
Example : bot5497182788:AAGXS-nArOMZaER_6xqfeOLW-VD-frlSfDM  

## 3. Creating Telegram Bot 

1. Create a bot using Telegram App.
2. Create a channel in Telegram and make your bot admin.
3. Finding your group/channel id.   

#### How to create a bot using Telegram App?
- Search for bot!
father Telegram App. It must have a blue tick on the right side. Click on botfather.     
- The command you need is:   ```/newbot``` which leads to the steps to create your unique bot.   
- Choose your bot name and username. Username must be unique and must end with “bot”.   
- You will get a message that contains your access token. This is also your <telegram bot id> will be used in your script. Save your access token in a safe place. Don’t share it and don’t lose it.
[1*c1XPaCfTdxGMLw6cyg9NtQ](https://user-images.githubusercontent.com/109391990/185745626-65679be7-5935-4203-b756-01dc9654109e.png)

[About Telegram Bot ](https://core.telegram.org/bots)

