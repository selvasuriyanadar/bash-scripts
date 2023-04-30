#!/bin/sh

if [[ -z "$backup_dir" ]]; then
  echo "backup_dir is required."
  exit 1
fi

if [[ -z "$conn" ]]; then
  echo "conn is required."
  exit 1
fi

if [[ -z "$mongodump_username" ]]; then
  echo "mongodump_username is required."
  exit 1
fi

if [[ -z "$mongodump_password" ]]; then
  echo "mongodump_password is required."
  exit 1
fi

if [[ -z "$backup_file_prefix" ]]; then
  echo "backup_file_prefix is required."
  exit 1
fi

if [[ -z "$mongodb_backup_file_prefix" ]]; then
  echo "mongodb_backup_file_prefix is required."
  exit 1
fi

# init
x=$(date +"%y-%m-%d")
backup_file_ext='sql'
mongodb_backup_file_ext='tar.gz'

backup_dir="${backup_dir}${x}/"

backup_file_name="${backup_file_prefix}-${x}.${backup_file_ext}"
mongodb_backup_file_name="${mongodb_backup_file_prefix}-${x}.${mongodb_backup_file_ext}"
local_file="${backup_dir}${backup_file_name}"
mongodb_local_file="${backup_dir}${mongodb_backup_file_name}"

# creating directory
mkdir $backup_dir

# creating backup
pg_dump --dbname=$conn > $local_file
mongodump --archive=$mongodb_local_file --gzip $mongo_conn
