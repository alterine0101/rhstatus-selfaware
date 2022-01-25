#!/bin/bash
declare -A roothouse0=(
  [device_id]='roothouse-0'
  [url]='http://192.168.10.10'
)
declare -A roothouse1=(
  [device_id]='roothouse-1'
  [url]='http://192.168.10.11'
)
declare -A roothouse2=(
  [device_id]='roothouse-2'
  [url]='http://192.168.10.12'
)
declare -A roothouse3=(
  [device_id]='roothouse-3'
  [url]='http://192.168.10.13'
)
declare -n roothouse
for roothouse in ${!roothouse@}; do
  echo "checking out ${roothouse[device_id]};"
  m=$(curl -s "${roothouse[url]}" 2>&1)
  if [ $? -ne 0 ] ; then
    echo "| unable to connect;"
  else
    output=$(curl -X POST "https://rhstatus-proxy.alterine0101.id/index.php" -F "secret=$RHSTATUS_PROXY_SECRET" -F "deviceId=${roothouse[device_id]}" -F "reportingSource=roothouse" -o -)
    echo "$output";
  fi
done
