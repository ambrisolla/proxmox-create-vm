#!/usr/bin/env python3

import os
import re

env_list = [
    'PROXMOX_HOST',
    'RD_OPTION_GATEWAY',
    'RD_OPTION_HOSTNAME',
    'RD_OPTION_IPADDR',
    'RD_OPTION_MEMORY',
    'RD_OPTION_NETMASK',
    'RD_OPTION_SSH_PASSWORD',
    'RD_OPTION_SSH_USER',
    'RD_OPTION_CORES',
    'RD_SECUREOPTION_SSH_PASSWORD',
    'SALT_MASTER_IP',
    'TEMPLATE_IP'
]


template_vars = open('vars/vm.tfvars', 'r').read()

for env in env_list:
    template_vars = re.sub(env,os.environ[env], template_vars)


new_template_vars = open('vars/vm.tfvars', 'w')
new_template_vars.write(template_vars)
new_template_vars.close()