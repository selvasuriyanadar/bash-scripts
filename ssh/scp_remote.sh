#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 \"remote file\" \"local file\"" >&2
  exit 1
fi

if [[ -z "$type" ]]; then
  echo "type is required."
  exit 1
fi
if [[ -z "$deploy_user" ]]; then
  echo "deploy user is required."
  exit 1
fi
if [ ! "dev" == "$type" ] && [ ! "live" == "$type" ] && [ ! "old_dev" == "$type" ]; then
  echo "type is invalid."
  exit 1
fi

. $(dirname $0)/set_ssh_host_port_key.sh

# init
deploy_domain="${deploy_user}@${deploy_host}"
scp_deploy_prefix="${deploy_domain}:"

scp -i $ssh_key -P $ssh_port $scp_deploy_prefix$1 $2
