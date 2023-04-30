#!/bin/sh

if [[ -z "$deploy_user" ]]; then
  echo "deploy user is required."
  exit 1
fi
if [[ -z "$port" ]]; then
  echo "port is required."
  exit 1
fi

. $(dirname $0)/set_ssh_host_port_key.sh

# init
deploy_domain="${deploy_user}@${deploy_host}"

ssh -i $ssh_key -p $ssh_port $deploy_domain -L $port:$deploy_host:$port
