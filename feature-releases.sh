#!/bin/zsh

# This script requires a release version to be provided. 
if [ -z $1 ]; then
    echo "Please provide a version as it appears in Jira\n"
    echo "Example: $0 \"Team x Feature\""
    exit 1
else
    version=$1
fi

echo "Sending commands to Jira:\n"

DATABLOCK='{"data":{"releaseVersion":"'$version'"}}'

curl -X POST -H 'Content-type: application/json' --data $DATABLOCK \
https://automation.atlassian.com/pro/hooks/(value)
echo "Moved issues in $version to Production status"

sleep 5

curl -X POST -H 'Content-type: application/json' --data $DATABLOCK \
https://automation.atlassian.com/pro/hooks/(value)
echo "$version marked as Released in Jira"

echo "Script complete"
exit 0
