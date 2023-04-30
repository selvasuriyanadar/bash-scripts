#!/bin/sh

API_KEY=_
log_file=_
x=$(date +"%y-%m-%d")
report_file="./report-${x}.json"

curl -X POST --data-binary @$log_file https://api.gceasy.io/analyzeGC?apiKey=$API_KEY --header "Content-Type:text" > $report_file
