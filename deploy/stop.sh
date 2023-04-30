#!/bin/sh

# config
deploy_port=_
 
# stopping the application
kill -9 $(lsof -t -i:$deploy_port)
