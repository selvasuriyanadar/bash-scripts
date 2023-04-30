#!/bin/sh

if [[ -z "$type" ]]; then
  echo "type is required."
  exit 1
fi
if [[ -z "$deploy_user" ]]; then
  echo "deploy user is required."
  exit 1
fi
if [ ! "dev" == "$type" ] && [ ! "live" == "$type" ]; then
  echo "type is invalid."
  exit 1
fi

. $(dirname $0)/set_ssh_host_port_key.sh

# init
deploy_domain="${deploy_user}@${deploy_host}"

ssh -i $ssh_key -p $ssh_port $deploy_domain
