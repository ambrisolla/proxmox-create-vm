#!/usr/bin/env python3

import os
import re

# RD_OPTION_GATEWAY=sd
# RD_OPTION_HOSTNAME=das
# RD_OPTION_IPADDR=dsa
# RD_OPTION_MEMORY=512
# RD_OPTION_NETMASK=das
# RD_OPTION_SSH_PASSWORD=das
# RD_OPTION_SSH_USER=das
# RD_OPTION_VCPUS=1
# RD_SECUREOPTION_SSH_PASSWORD=das
# NETMASK__=255.255.255.0
# PROXMOX_HOST__=https://proxmox.imbrisa.io:8006/api2/json
# SALT_MASTER_IP__=192.168.0.201
# TEMPLATE_IP__=192.168.0.250

env_list = [
    'PROXMOX_HOST',
    'PROXMOX_PASS',
    'PROXMOX_USER',
    'RD_OPTION_GATEWAY',
    'RD_OPTION_HOSTNAME',
    'RD_OPTION_IPADDR',
    'RD_OPTION_MEMORY',
    'RD_OPTION_NETMASK',
    'RD_OPTION_SSH_PASSWORD',
    'RD_OPTION_SSH_USER',
    'RD_OPTION_VCPUS',
    'RD_SECUREOPTION_SSH_PASSWORD',
    'SALT_MASTER_IP',
    'TEMPLATE_IP'
]



template_vars = open('vars/vm.tfvars', 'r').read()


for env in env_list:
    template_vars = re.sub(env,os.environ(env), template_vars)

print(template_vars)