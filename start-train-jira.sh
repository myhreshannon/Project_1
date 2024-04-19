#!/bin/zsh

# This script targets the Create Train Station 
# https://(company).atlassian.net/jira/software/c/projects/(JIRA)/settings/automate#/rule/(#)
# 
# and Train Station - Switch Trains automation rules
# https://(company).atlassian.net/jira/software/c/projects/(JIRA)/settings/automate#/rule/(#)

# No arguments are needed for this script

DATE=$(date -v +1d '+%y.%m.%d')
version="v$DATE"

DATABLOCK='{"data":{"oldVersion":"'Next\ Deployment'","newVersion":"'$version'"}}'

echo "Creating release"
curl -X POST -H 'Content-type: application/json' \
https://automation.atlassian.com/pro/hooks/(value) > /dev/null


echo "Moving issues from Next Deployment to release train"
curl -X POST -H 'Content-type: application/json' --data $DATABLOCK \
https://automation.atlassian.com/pro/hooks/(value) > /dev/null

echo "Commands sent to Jira"

exit 0



