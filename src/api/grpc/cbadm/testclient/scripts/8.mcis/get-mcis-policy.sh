#!/bin/bash

#function get_mcis() {


	TestSetFile=${5:-../testSet.env}
    
    if [ ! -f "$TestSetFile" ]; then
        echo "$TestSetFile does not exist."
        exit
    fi
	source $TestSetFile
    source ../conf.env
	
	echo "####################################################################"
	echo "## 8. VM: Get MCIS Policy"
	echo "####################################################################"

	CSP=${1}
	REGION=${2:-1}
	POSTFIX=${3:-developer}
	MCISNAME=${4:-noname}

	source ../common-functions.sh
	getCloudIndex $CSP


	MCISID=${CONN_CONFIG[$INDEX,$REGION]}-${POSTFIX}

	if [ "${INDEX}" == "0" ]; then
		# MCISPREFIX=avengers
		MCISID=${MCISPREFIX}-${POSTFIX}
	fi

	if [ "${MCISNAME}" != "noname" ]; then
		echo "[MCIS name is given]"
		MCISID=${MCISNAME}
	fi

	$CBTUMBLEBUG_ROOT/src/api/grpc/cbadm/cbadm mcis get-policy --config $CBTUMBLEBUG_ROOT/src/api/grpc/cbadm/grpc_conf.yaml -o json --ns $NSID --mcis $MCISID | jq ''
#}

#get_mcis