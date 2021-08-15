#!/bin/bash

date=$(date +%D)
echo "System Info - $date"

uname=$(uname)
echo -e "\nThe uname is: $uname"

ip=$(hostname -I)
echo -e "\nThe IP address is: $ip"

echo -e "\nThe hostname is : $HOSTNAME"

dns=$(cat /etc/resolv.conf | grep nameserver)
echo -e "\nDNS info: $dns"

mem=$(free)
echo -e "\nThe Memory info is: $mem"

cpu=$(head /proc/cpuinfo)
echo -e "\nThe CPU Info is: $cpu"

disk=$(df | head)
echo -e "\nThe disk free report is: $disk"

users=$(w)
echo -e "\nThe logged in users are: $users"
