#!/bin/sh

if [[ -z "$drive_init_dir" ]]; then
  echo "drive_init_dir is required."
  exit 1
fi

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

if [[ -z "$mongodb_backup_temp_dir" ]]; then
  echo "mongodb_backup_temp_dir is required."
  exit 1
fi

# init
x=$(date +"%y-%m-%d")
backup_file_ext='sql'
mongodb_backup_file_ext='tar.gz'

backup_dir="${backup_dir}${x}/"
backup_local_dir="${drive_init_dir}${backup_dir}"
backup_drive_dir="${backup_dir}"

backup_file_name="${backup_file_prefix}-${x}.${backup_file_ext}"
mongodb_backup_file_name="${mongodb_backup_file_prefix}-${x}.${mongodb_backup_file_ext}"
local_file="${backup_local_dir}${backup_file_name}"
drive_file="${backup_drive_dir}${backup_file_name}"
mongodb_backup_temp_dir="${backup_local_dir}${mongodb_backup_temp_dir}"
mongodb_local_file="${backup_local_dir}${mongodb_backup_file_name}"
mongodb_drive_file="${backup_drive_dir}${mongodb_backup_file_name}"

# changing to drive init directory
cd $drive_init_dir

# creating local directory
mkdir -p $backup_local_dir
touch $local_file $mongodb_local_file # for preventing pre usage clean up of the local directory

# creating drive folder
drive new -folder $backup_drive_dir

# creating backup
pg_dump --dbname=$conn > $local_file
mongodump -u $mongodump_username -p $mongodump_password $mongodb_backup_temp_dir
tar -czf $mongodb_local_file $mongodb_backup_temp_dir --remove-files

# pushing backup to drive
drive push -no-prompt $drive_file

# clearing local file
rm -r $backup_local_dir
find $drive_init_dir -type d -empty -delete
