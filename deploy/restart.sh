#!/bin/sh

# config
deploy_dir=_
deploy_port=_
deploy_data_dir=_

# init
deploy_jar="${deploy_dir}deploy.jar"
deploy_log="${deploy_data_dir}logs/nohup.out"
 
# stopping the application
kill -9 $(lsof -t -i:$deploy_port)

# starting the application
cd $deploy_dir
nohup java -jar $deploy_jar >> $deploy_log &
