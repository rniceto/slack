#!/bin/bash
################### FORKED https://github.com/ericoc/zabbix-slack-alertscript #####################


# Slack incoming web-hook URL and user name
url=''
username='app'

to="$1"
subject="$2"


recoversub='^RECOVER(Y|ED)?$'
if [[ "$subject" =~ ${recoversub} ]]; then
	emoji=':smile:'
elif [ "$subject" == 'PROBLEM' ]; then
	emoji=':frowning:'
else
	emoji=':ghost:'
fi


message="${subject}: $3"


payload="payload={\"channel\": \"${to//\"/\\\"}\", \"username\": \"${username//\"/\\\"}\", \"text\": \"${message//\"/\\\"}\", \"icon_emoji\": \"${emoji}\"}"
curl -m 5 --data-urlencode "${payload}" $url -A 'slack / https://github.com/rniceto/slack'
