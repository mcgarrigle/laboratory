#!/bin/bash

source 00-environment.sh

yum install -y firewalld vim httpd
yum install -y epel-release
yum install -y tinyproxy

# assumption: eth1 is up and configured via DHCP during kickstart

if-configure "${ETH0}" "${FOR_ADDRESS}" "255.255.255.0"

ifup ${ETH0}

hostnamectl set-hostname ${FOR_SERVER}

echo "${FOR_ADDRESS} ${FOR_SERVER} foreman" >> /etc/hosts

# stop host connections stalling on DNS lookup

echo "UseDNS no" >> /etc/ssh/sshd_config


