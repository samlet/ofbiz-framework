#!/bin/bash
set -e

RED='\033[0;31m'
NC='\033[0m' # No Color

function wait_s(){	
	local servname=$1
	local logfile=$2
	local matcher=$3
	sleep 0.15
	tail -f $logfile | while read LOGLINE
	do
		echo ${LOGLINE}
	    [[ "${LOGLINE}" == *"${matcher}"* ]] && pkill -P $$ tail
	done
	echo "start $servname ok."
}

# call syntax:
# 	start_ofbiz console "$msg_redis"
function start_ofbiz(){
	local curdir=`pwd`

	#1
	local comp_name="$1"
	printf "${RED}==> $comp_name ${NC}...\n"

	# mkdir -p logs
	local logs_file="./runtime/logs/$comp_name.log"
	#2
	rm -f $logs_file
	touch $logs_file

	#3
	# local cmd="./gradlew terminateOfbiz ofbizBackground"
	local cmd="./gradlew terminateOfbiz ofbiz"
	# local cmd="./gradlew ofbiz"
	nohup $cmd > $logs_file 2>&1 &

	wait_s $comp_name $logs_file "$2"

	cd $curdir
}
