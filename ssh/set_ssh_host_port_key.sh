#!/bin/sh

if [[ -z "$dev_ssh_key" ]]; then
  echo "dev_ssh_key is required."
  exit 1
fi
if [[ -z "$dev_deploy_host" ]]; then
  echo "dev_deploy_host is required."
  exit 1
fi
if [[ -z "$dev_ssh_port" ]]; then
  echo "dev_ssh_port is required."
  exit 1
fi

#dev
if [ "dev" == "$type" ]; then
  ssh_key=$dev_ssh_key
  deploy_host=$dev_deploy_host
  ssh_port=$dev_ssh_port
fi

if [[ -z "$live_ssh_key" ]]; then
  echo "live_ssh_key is required."
  exit 1
fi
if [[ -z "$live_deploy_host" ]]; then
  echo "live_deploy_host is required."
  exit 1
fi
if [[ -z "$live_ssh_port" ]]; then
  echo "live_ssh_port is required."
  exit 1
fi

#live
if [ "live" == "$type" ]; then
  ssh_key=$live_ssh_key
  deploy_host=$live_deploy_host
  ssh_port=$live_ssh_port
fi

if [[ -z "$old_dev_ssh_key" ]]; then
  echo "old_dev_ssh_key is required."
  exit 1
fi
if [[ -z "$old_dev_deploy_host" ]]; then
  echo "old_dev_deploy_host is required."
  exit 1
fi
if [[ -z "$old_dev_ssh_port" ]]; then
  echo "old_dev_ssh_port is required."
  exit 1
fi

if [ "old_dev" == "$type" ]; then
  ssh_key=$old_dev_ssh_key
  deploy_host=$old_dev_deploy_host
  ssh_port=$old_dev_ssh_port
fi
