#!/bin/sh
#
# Paranoid
#
# Universal script for blocking input attacks, bots
# and another trash from World Wide Web network.
#
# FOR PRIVATE USING | NOT FOR PUBLIC | CONFIDENTIAL
#
# COPYRIGHT (c) 2021, Aliase Network (contact@aliase.net)
# 
# https://github.com/Aliase/paranoid
# Cleaning command line
clear
# Welcome text
printf "\nWelcome to Paranoid. Waiting 5 seconds to start..."
# Sleep 5 seconds
sleep 5s
# Text for ICMP blocking
printf "\n\nBlocking ICMP protocol..."
# Block ICMP protocol
iptables -A INPUT --proto icmp -j DROP
# Adding ignore ICMP to core settings
echo "1" > /proc/sys/net/ipv4/icmp_echo_ignore_all
echo "net.ipv4.icmp_echo_ignore_all = 1" >> /etc/sysctl.conf 
# Done text
printf "\nDone. Next step..."
# Text for Shodan blocking
printf "\n\nBlocking Shodan..."
# Block Shodan
while read shodan; do
    iptables -A INPUT -s $shodan -j DROP
done < txts/shodan.txt
# Done text
printf "\nDone. Next step..."
# Text for Censys and Project25499 blocking
printf "\n\nBlocking Censys and Project25499..."
while read censys-project25499; do
    iptables -A INPUT -s $censys-project25499 -j DROP
done < txts/censys-project25499.txt
# Done text
printf "\nDone. Next step..."
# Text for Black IP blocking
printf "\n\nBlocking Black IP (DDoS, Spam, Bruteforce)..."
# Blocking Black IP
while read blacklist; do
    iptables -A INPUT -s $blacklist -j DROP
done < txts/blacklist.txt
# Done text
printf "\nDone. Next step..."
# Saving text
printf "\n\nSaving IPtables rules..."
# Saving iptables rules
iptables-save
# Done text
printf "\nDone, all OK. Goodbye!\n"
# Sleep 5 seconds
sleep 5s
# Exit
exit