#!/bin/bash

network_config() {
  IPADDR=$1
  NETMASK=$2
  GATEWAY=$3
  NIC=$( \
    nmcli con show   | \
    grep -v ^NAME    | \
    awk '{print $1}' | \
    head -1 )

  echo "nameserver 192.168.0.210" > /etc/resolv.conf
  echo "nameserver 1.1.1.1" >> /etc/resolv.conf
  echo "search imbrisa.io" >> /etc/resolv.conf

  echo "# created by terraform 
  BOOTPROTO=static
  DEVICE=${NIC}
  NAME=${NIC}
  ONBOOT=yes
  TYPE=Ethernet
  USERCTL=no
  IPADDR=${IPADDR}
  NETMASK=${NETMASK}
  DNS1=${GATEWAY}
  DNS2=1.1.1.1
  GATEWAY=${GATEWAY}" > /etc/sysconfig/network-scripts/ifcfg-$NIC
  
  sudo touch /reboot_please

}

salt_config() {

  # set repository
  rpm --import https://repo.saltproject.io/salt/py3/redhat/8/x86_64/latest/SALTSTACK-GPG-KEY.pub
  curl -fsSL https://repo.saltproject.io/py3/redhat/8/x86_64/3004.repo | sudo tee /etc/yum.repos.d/salt.repo

  # Install salt minion
  yum install salt-minion -y -q

  # configure minion
  SALT_MASTER=$1
  sed -i "/^#startup_states:/d;/^#master:/d" /etc/salt/minion
  echo "startup_states: ['highstate']"    >> /etc/salt/minion
  echo "master: ${SALT_MASTER}"           >> /etc/salt/minion

  # start salt-minion
  systemctl enable salt-minion && sudo systemctl start salt-minion

}

network_config $1 $2 $3
salt_config $4