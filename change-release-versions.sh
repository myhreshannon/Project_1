#!/bin/zsh

# This script targets the Train Station - Switch trains automation rule
# https://(company).atlassian.net/jira/software/c/projects/(PC)/settings/automate#/rule/(num)

# Check to make sure we provided a version
if [ -z $2 ]; then 
    echo "Please provide two arguments, the fix version you want to remove and the version you want to change to"
    echo "ex: $0 v22.05.11 v22.05.12"
    exit 2
fi

WEBHOOK=https://automation.atlassian.com/pro/hooks/(hash)
DATABLOCK='{"data":{"oldVersion":"'$1'","newVersion":"'$2'"}}'

curl -X POST -H 'Content-type: application/json' --data $DATABLOCK $WEBHOOK > /dev/null

echo "Command sent to Jira"

exit 0
