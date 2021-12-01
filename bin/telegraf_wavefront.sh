# This file is not currently in use, I would like to add it to each of the modularized "input module" shellscripts

## Wavefront Out
export WAVEFRONT_HOST=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-concourse-wavefront-out").credentials.wavefront_host'`
export WAVEFRONT_PORT=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-concourse-wavefront-out").credentials.wavefront_port'`
