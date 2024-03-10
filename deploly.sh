#!/bin/bash



LOG_DIR="logs"
MONGO_DEPLOY_TYPE="$1"
MONGO_USESTATEFULSET=true
VALUES_FILE="values.yaml"


mkdir -p "$LOG_DIR"

log() {

	local msg="$1"
	local log_file="$LOG_DIR/$(date '+%Y%m%d_%H%M%S')_${FUNCNAME[1]}.log"
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $msg" | tee -a "$log_file"

}


handle_error() {
	local exit_code="$1"
	local error_msg="$2"
	log "Error: $error_msg"
    	exit "$exit_code"
}


setup_kind() {
	log "Setting up kind cluster..."
	#echo fs.inotify.max_user_watches=655360 | sudo tee -a /etc/sysctl.conf
	#echo fs.inotify.max_user_instances=1280 | sudo tee -a /etc/sysctl.conf
	#sudo sysctl -p
	sleep 5
	log "Checking if FeedbackAppCluster is already up and running in the system."
	CLUSTER_EXIST=$( kind get clusters | grep "feedbackapp-cluster" )
	if [ "$CLUSTER_EXIST" == "feedbackapp-cluster" ]; then
		log "Cluster FeedbackAppCluster is already up and running, contiuing config without creating new cluster."
	else
		log "Creating new cluster name feedbackapp-cluster. This proccess might take a few minuets.."
		kind create cluster --config clusterConfig.yaml &> "$LOG_DIR/kind_create.log" || handle_error "$?" "Failed to create kind cluster."
		sleep 15
		log "Successfully created Kind cluster!"
	fi
}






deploy_type_mongo() {
	
	read -p "Enter deployment type (standAlone or cluster):" DEPLOY_TYPE

	if [ "$DEPLOY_TYPE" != "standAlone" ] && [ "$DEPLOY_TYPE" != "cluster" ]; then
        
		handle_error 1 "Invalid deploy type: $DEPLOY_TYPE"
	
	elif [ "$DEPLOY_TYPE" == "standAlone" ]; then
		MONGO_USESTATEFULSET=false
	fi

	log "Deployment type: $DEPLOY_TYPE"
	
	log "Setting mongo type..."
	sleep 2
}

main() {

#setup_kind
deploy_type_mongo
helm install feedbackapp . --set mongo.useStatefulSet=$MONGO_USESTATEFULSET

}

main



