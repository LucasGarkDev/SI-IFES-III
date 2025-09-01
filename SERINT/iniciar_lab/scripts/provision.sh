#!/bin/bash
apt update && apt upgrade -y
apt install -y net-tools curl openssh-server
systemctl enable ssh
systemctl start ssh