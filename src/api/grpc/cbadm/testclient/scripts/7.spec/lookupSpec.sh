#!/bin/bash

#function lookup_spec() {


	TestSetFile=${4:-../testSet.env}
    if [ ! -f "$TestSetFile" ]; then
        echo "$TestSetFile does not exist."
        exit
    fi
	source $TestSetFile
    source ../conf.env
	
	echo "####################################################################"
	echo "## 7. spec: Lookup Spec"
	echo "####################################################################"

	CSP=${1}
	REGION=${2:-1}
	POSTFIX=${3:-developer}

	source ../common-functions.sh
	getCloudIndex $CSP

	$CBTUMBLEBUG_ROOT/src/api/grpc/cbadm/cbadm spec get-csp --config $CBTUMBLEBUG_ROOT/src/api/grpc/cbadm/grpc_conf.yaml -o json --cc ${CONN_CONFIG[$INDEX,$REGION]} --spec ${SPEC_NAME[$INDEX,$REGION]} | jq ''
    echo ""
#}

#lookup_spec
