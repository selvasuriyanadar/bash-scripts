#!/bin/sh

if [[ -z "$src_type" ]]; then
  echo "src type is required."
  exit 1
fi
if [[ -z "$type" ]]; then
  echo "type is required."
  exit 1
fi
if [ ! "booma"  == "$src_type" ] && [ ! "plcampus"  == "$src_type" ] && [ ! "plcampusfrontend"  == "$src_type" ]; then
  echo "src type is invalid."
  exit 1
fi
if [ ! "dev" == "$type" ] && [ ! "live" == "$type" ]; then
  echo "type is invalid."
  exit 1
fi

if [[ -z "$booma_src_root" ]]; then
  echo "booma_src_root is required."
  exit 1
fi
if [[ -z "$booma_target_jar" ]]; then
  echo "booma_target_jar is required."
  exit 1
fi
if [[ -z "$booma_dev_deploy_dir" ]]; then
  echo "booma_dev_deploy_dir is required."
  exit 1
fi
if [[ -z "$booma_dev_deploy_user" ]]; then
  echo "booma_dev_deploy_user is required."
  exit 1
fi
if [[ -z "$booma_live_deploy_dir" ]]; then
  echo "booma_live_deploy_dir is required."
  exit 1
fi
if [[ -z "$booma_live_deploy_user" ]]; then
  echo "booma_live_deploy_user is required."
  exit 1
fi

#booma
if [ "booma" == "$src_type" ]; then
  if [ "dev" == "$type" ]; then
    deploy_dir=$booma_dev_deploy_dir
    deploy_user=$booma_dev_deploy_user
  fi
  if [ "live" == "$type" ]; then
    deploy_dir=$booma_live_deploy_dir
    deploy_user=$booma_live_deploy_user
  fi
  src_root=$booma_src_root
  target_jar=$booma_target_jar
fi

if [[ -z "$plcampus_src_root" ]]; then
  echo "plcampus_src_root is required."
  exit 1
fi
if [[ -z "$plcampus_target_jar" ]]; then
  echo "plcampus_target_jar is required."
  exit 1
fi
if [[ -z "$plcampus_dev_deploy_dir" ]]; then
  echo "plcampus_dev_deploy_dir is required."
  exit 1
fi
if [[ -z "$plcampus_dev_deploy_user" ]]; then
  echo "plcampus_dev_deploy_user is required."
  exit 1
fi
if [[ -z "$plcampus_live_deploy_dir" ]]; then
  echo "plcampus_live_deploy_dir is required."
  exit 1
fi
if [[ -z "$plcampus_live_deploy_user" ]]; then
  echo "plcampus_live_deploy_user is required."
  exit 1
fi

#plcampus
if [ "plcampus" == "$src_type" ]; then
  if [ "dev" == "$type" ]; then
    deploy_dir=$plcampus_dev_deploy_dir
    deploy_user=$plcampus_dev_deploy_user
  fi
  if [ "live" == "$type" ]; then
    deploy_dir=$plcampus_live_deploy_dir
    deploy_user=$plcampus_live_deploy_user
  fi
  src_root=$plcampus_src_root
  target_jar=$plcampus_target_jar
fi

if [[ -z "$plcampusfrontend_src_root" ]]; then
  echo "plcampusfrontend_src_root is required."
  exit 1
fi
if [[ -z "$plcampusfrontend_target_jar" ]]; then
  echo "plcampusfrontend_target_jar is required."
  exit 1
fi
if [[ -z "$plcampusfrontend_dev_deploy_dir" ]]; then
  echo "plcampusfrontend_dev_deploy_dir is required."
  exit 1
fi
if [[ -z "$plcampusfrontend_dev_deploy_user" ]]; then
  echo "plcampusfrontend_dev_deploy_user is required."
  exit 1
fi
if [[ -z "$plcampusfrontend_live_deploy_dir" ]]; then
  echo "plcampusfrontend_live_deploy_dir is required."
  exit 1
fi
if [[ -z "$plcampusfrontend_live_deploy_user" ]]; then
  echo "plcampusfrontend_live_deploy_user is required."
  exit 1
fi

#plcampusfrontend
if [ "plcampusfrontend" == "$src_type" ]; then
  if [ "dev" == "$type" ]; then
    deploy_dir=$plcampusfrontend_dev_deploy_dir
    deploy_user=$plcampusfrontend_dev_deploy_user
  fi
  if [ "live" == "$type" ]; then
    deploy_dir=$plcampusfrontend_live_deploy_dir
    deploy_user=$plcampusfrontend_live_deploy_user
  fi
  src_root=$plcampusfrontend_src_root
  target_jar=$plcampusfrontend_target_jar
fi

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

# init
target_jar="${src_root}target/${target_jar}.jar"
temp_deploy_jar="${deploy_dir}temp_deploy.jar"
deploy_jar="${deploy_dir}deploy.jar"
deploy_domain="${deploy_user}@${deploy_host}"
scp_deploy_prefix="${deploy_domain}:"
move_script="mv ${temp_deploy_jar} ${deploy_jar}"
deploy_script="bash ${deploy_dir}restart.sh"

# packaging
cd "$src_root"
mvn clean
mvn package

# uploading
scp -i $ssh_key -P $ssh_port "$target_jar" $scp_deploy_prefix$temp_deploy_jar

# moving
ssh -i $ssh_key -p $ssh_port  $deploy_domain $move_script

# restarting
ssh -i $ssh_key -p $ssh_port  $deploy_domain $deploy_script
