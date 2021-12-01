## Default Telegraf
export INTERVAL=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[]| select(.instance_name | endswith("-default")).credentials.interval'`
export ROUND_INTERVAL=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name | endswith("-default")).credentials.round_interval'`
export METRIC_BATCH_SIZE=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name | endswith("-default")).credentials.metric_batch_size'`
export METRIC_BUFFER_LIMIT=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name | endswith("-default")).credentials.metric_buffer_limit'`
export COLLECTION_JITTER=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name | endswith("-default")).credentials.collection_jitter'`
export FLUSH_INTERVAL=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name | endswith("-default")).credentials.flush_interval'`
export FLUSH_JITTER=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name | endswith("-default")).credentials.flush_jitter'`
export PRECISION=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name | endswith("-default")).credentials.precision'`
export DEBUG=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name | endswith("-default")).credentials.debug'`

echo "Running telegraf binary"
telegraf -config /etc/telegraf/telegraf.conf -config-directory /etc/telegraf/telegraf.d
