## Concourse In 
export CONCOURSE_URL=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-concourse-in").credentials.concourse_url'`

## Wavefront Out
export WAVEFRONT_HOST=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-concourse-wavefront-out").credentials.wavefront_host'`
export WAVEFRONT_PORT=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-concourse-wavefront-out").credentials.wavefront_port'`

/bin/telegraf.sh
