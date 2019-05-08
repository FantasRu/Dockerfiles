#!/bin/bash

check_non_empty() {
  # $1 is the content of the variable in quotes e.g. "$FROM_EMAIL"
  # $2 is the error message
  if [[ "$1" == "" ]]; then
    echo "ERROR: specify $2"
    exit -1
  fi
}

check_exec_success() {
  # $1 is the content of the variable in quotes e.g. "$FROM_EMAIL"
  # $2 is the error message
  if [[ "$1" != "0" ]]; then
    echo "ERROR: $2 failed"
    echo "$3"
    exit -1
  fi
}

CurDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ -a ${CurDir}/envs.sh ]]; then
  source ${CurDir}/envs.sh
fi

# get config vars
if [[ -z "$NodeName" ]]; then
  NodeName="$(hostname)"
elif [[ -n "$XNN" ]]; then
  NodeName="$XNN"
fi
NodeDisk="${NodeDisk:-hdd}"
if [[ -n "$XND" ]]; then
  NodeDisk="$XND"
fi

check_non_empty "${NodeName}" "NodeName"
check_non_empty "${NodeDisk}" "NodeDisk"

# get host ip
#HostIP="$(ip route get 1 | awk '{print $NF;exit}')"
HostIP=127.0.0.1
# set data dir
ESData=/data/elasticsearch/data
ESLog=/data/elasticsearch/logs

update_images() {
  # pull elasticsearch docker image
  docker pull do.17bdc.com/shanbay/elasticsearch:2

  check_exec_success "$?" "pulling 'elasticsearch' image"
}

start() {

  update_images

  docker kill elasticsearch 2>/dev/null
  docker rm -v elasticsearch 2>/dev/null

  docker run -d --name elasticsearch \
    -v ${ESData}:/usr/share/elasticsearch/data \
    -v ${ESLog}:/usr/share/elasticsearch/logs \
    -p 9200:9200 \
    --net=bridge \
    --restart=always \
    --log-opt max-size=10m \
    --log-opt max-file=9 \
    elasticsearch:2-heap10g \
    --index.number_of_replicas=0 \
    --node.name=${NodeName} \
    --node.disk=${NodeDisk} \
    --cluster.name=shanbay \
    --network.bind_host=0.0.0.0 \
    --network.publish_host=${HostIP}

  check_exec_success "$?" "start elasticsearch container"

 # curl -XPOST http://${HostIP}:8500/v1/agent/service/register -d "{
 #     \"Name\": \"elasticsearch\",
 #     \"Tags\": [\"${NodeDisk}\", \"${NodeName}\"],
 #     \"Port\": 9200,
 #     \"Check\": {\"HTTP\": \"http://${HostIP}:9200\", \"Interval\": \"30s\"}
 #   }"

}

stop() {
  curl http://${HostIP}:8500/v1/agent/service/deregister/elasticsearch
  docker stop elasticsearch 2>/dev/null
  docker rm -v elasticsearch 2>/dev/null
}

destroy() {
  stop
  rm -rf ${ESData}
  rm -rf ${ESLog}
}


##################
# Start of script
##################

case "$1" in
  start) start ;;
  stop) stop ;;
  restart)
    stop
    start
    ;;
  destroy) destroy ;;
  *)
    echo "Usage:"
    echo "./elasticsearch.sh start|stop|restart"
    echo "./elasticsearch.sh destroy"
    exit 1
    ;;
esac

exit 0

