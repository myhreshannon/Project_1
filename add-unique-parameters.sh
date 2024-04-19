#!/usr/bin/env bash
# Author: myhreshannon
# Description: This script expects a csv file with a service, environment, and value on each row.
#              It will translate each row into an aws cli command to add the parameter
#              Please have the input file in the same folder as this script or it will add the folder in the name
#
# Requirements: Active AWS SSO session in the terminal this is to be run from

# The -e makes it stop if there's an error
# Delete the e if you want it to continue instead
set -eo pipefail

if [ -z $1 ]; then
    echo "Please provide a .csv file. The file name needs to be the new variable name"
    echo "Ex: $0 app_url.csv"
    exit 2
fi

# Check for file
if [ -f $1 ]; then
    NAME=`echo "${1%.*}" | awk '{print toupper($0)}'` # strip extension and make it uppercase
else
    echo "File not found"
    exit 2    
fi

echo "Adding $NAME"

# Add timestamp to results log
date >> add-var-results.txt

SERVICES=("ONE" "TWO" "THREE" "FOUR")

# Read input
while IFS="," read service env value
do
    # Ignore header row
    if [ $service = "service" ]
    then
        continue
    fi

    # Check for valid service
    SERVICE=`echo "$service" | awk '{print toupper($0)}'`
    if [[ ${SERVICES[*]} =~ $SERVICE ]]; then
        echo "Adding $service parameter"
    else    
        echo "$SERVICE is not a valid service. Please use one of the following"
        for s in ${SERVICES[@]}; do 
            echo "$s" 
        done
        exit 3
    fi
    
    ENV=`echo "$env" | awk '{print toupper($0)}'`
    echo "/STAGING/$SERVICE/$ENV/$NAME:$value" >> add-var-results.txt

    # add it
    aws ssm put-parameter --name "/STAGING/$SERVICE/$ENV/$NAME" --value "$value" --type "String" >> add-var-results.txt
done < $1

# New line to make it easier to see different batches
printf "\n" >> add-var-results.txt

exit 0
