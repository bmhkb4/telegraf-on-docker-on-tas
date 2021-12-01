## Vsphere In
export VCENTERS=`echo "${VCAP_SERVICES}"| jq -r '."some-environment-variable"[].credentials.credentials.CLOUDFOUNDRY_VCENTER_API.url'`
export USERNAME=`echo "${VCAP_SERVICES}"| jq -r '."some-environment-variable"[].credentials.credentials.CLOUDFOUNDRY_VCENTER_API.username'`
export PASSWORD=`echo "${VCAP_SERVICES}"| jq -r '."some-environment-variable"[].credentials.credentials.CLOUDFOUNDRY_VCENTER_API.password'`

# I couldn't get the telegraf agent to parse these correctly, since it's an array in an environment variable, so they are hard coded in the template for now
#export VM_METRIC_INCLUDE=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-in-vsphere").credentials.vm_metric_include'`
#export HOST_METRIC_INCLUDE=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-in-vsphere").credentials.host_metric_include'`

## Wavefront Out
export WAVEFRONT_HOST=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-vsphere-wavefront-out").credentials.wavefront_host'`
export WAVEFRONT_PORT=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-vsphere-wavefront-out").credentials.wavefront_port'`

/bin/telegraf.sh
