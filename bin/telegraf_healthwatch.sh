## Healthwatch In 
export HEALTHWATCH_COUNTER_URL=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-healthwatch-in").credentials.healthwatch_counter_url'`
export HEALTHWATCH_GAUGE_URL=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-healthwatch-in").credentials.healthwatch_gauge_url'`
export HEALTHWATCH_TIMER_URL=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-healthwatch-in").credentials.healthwatch_timer_url'`
export HEALTHWATCH_SLI_URL=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-healthwatch-in").credentials.healthwatch_sli_url'`
export HEALTHWATCH_BOSHHEALTH_URL=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-healthwatch-in").credentials.healthwatch_boshhealth_url'`
export HEALTHWATCH_BOSHDEP_URL=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-healthwatch-in").credentials.healthwatch_boshdep_url'`
export HEALTHWATCH_CERTEXPIRATION_URL=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-healthwatch-in").credentials.healthwatch_certexpiration_url'`

echo "${VCAP_SERVICES}"| jq -r '."some-environment-variable"[].credentials.credentials.CLOUDFOUNDRY_KEY_PEM_HEALTHWATCH_API.password' |sed -E 's/(BEGIN|END|RSA|PRIVATE) /\1_/g' | tr ' ' '\n' | tr '_' ' ' > healthwatch.key
echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-healthwatch-in").credentials.healthwatchcert' |sed -E 's/(BEGIN|END) /\1_/g' | tr ' ' '\n' | tr '_' ' ' > healthwatch.cert
echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-healthwatch-in").credentials.healthwatchca' > healthwatch.ca


## Wavefront Out
export WAVEFRONT_HOST=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-healthwatch-wavefront-out").credentials.wavefront_host'`
export WAVEFRONT_PORT=`echo "${VCAP_SERVICES}"| jq -r '."user-provided"[] | select(.instance_name == "telegraf-healthwatch-wavefront-out").credentials.wavefront_port'`

/bin/telegraf.sh
