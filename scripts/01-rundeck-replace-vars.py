#!/usr/bin/env python3



# RD_OPTION_GATEWAY=sd
# RD_OPTION_HOSTNAME=das
# RD_OPTION_IPADDR=dsa
# RD_OPTION_MEMORY=512
# RD_OPTION_NETMASK=das
# RD_OPTION_SSH_PASSWORD=das
# RD_OPTION_SSH_USER=das
# RD_OPTION_VCPUS=1
# RD_SECUREOPTION_SSH_PASSWORD=das
# __GATEWAY__=192.168.0.1
# __HOSTNAME__=teste
# __IP_ADDR__=192.168.0.222
# __NETMASK__=255.255.255.0
# __PROXMOX_HOST__=https://proxmox.imbrisa.io:8006/api2/json
# __SALT_MASTER_IP__=192.168.0.201
# __TEMPLATE_IP__=192.168.0.250



template_vars = open('vars/vm.tf.vars', 'r').read()
print(template_vars)
