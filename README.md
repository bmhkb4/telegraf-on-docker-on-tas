# Prereqs
* * *

## 1. Learn Telegraf 
1. Review the [Documentation](https://docs.influxdata.com/telegraf/v1.18/introduction/getting-started/)
1. Understand Configuration Injection
    * We are using [Environment Variable to Configuration File mapping](https://docs.influxdata.com/telegraf/v1.15/administration/configuration/#example-telegraf-environment-variables) and [Cloud Foundry User Provided Services](https://docs.pivotal.io/tiledev/2-10/user-provided.html) to empower dynamic configuration

        **NOTE:** You can connect the dots yourself by following the logic:

        1. [CF User Provided Service](./config/healthwatch/cups/default_telegraf_config.json)
        1. [Mapping USPs to Environment Variables](./bin/telegraf.sh)
        1. [Using those environment variables in configuration files](./templates/default_telegraf.conf)

1. Understand the Modules
    * We have 3 pre-defined Input modules:
        * [Healthwatch](./HEALTHWATCHREADME.md)
        * [Vsphere](./VSPHEREREADME.md)
        * [Concourse](./CONCOURSEREADME.md)
    * and 1 pre-defined Output module
        * [Wavefront Proxy](https://github.com/influxdata/telegraf/tree/master/plugins/outputs/wavefront)

    **NOTE:** The current design is 1 INPUT and 1 OUTPUT module per container, and ALL containers use Wavefront OUT

## 2. Enable Docker on PCF (admin only command)
```
 cf enable-feature-flag diego_docker
```

## 3. Credentials Injection
You need a way to get creds into the container and parsed so the telegraf agent can use it.  Credhub on Tanzu Application Services injects them as Environment Variable:
```
'."some-environment-variable"[].credentials.credentials.CLOUDFOUNDRY_KEY_PEM_HEALTHWATCH_API.password'
```
and you can see us parsing the credentials in an example [here](./bin/telegraf_healthwatch.sh#L10).


# Build Docker Containers
* * *

## Build the customized container
This step is to build the customized input/output plugin into a docker container.
```
<sudo to root?>
docker login dummydockerrepo.com
docker build . -f concourse_dockerfile  -t dummydockerrepo.com/repo/telegraf:concourse_v0.1
docker build . -f vsphere_dockerfile  -t dummydockerrepo.com/repo/telegraf:vsphere_v0.1
docker build . -f healthwatch_dockerfile  -t dummydockerrepo.com/repo/telegraf:healthwatch_v0.1
docker push dummydockerrepo.com/repo/telegraf:healthwatch_v0.1
docker push dummydockerrepo.com/repo/telegraf:concourse_v0.1
docker push dummydockerrepo.com/repo/telegraf:vsphere_v0.1
```

# Push Telegraf containers to PCF
* * *

## 1. Log in to Clown Foundry (Tanzu Application Services)
```
cf login -a https://api.<env>.cf.example.com -u <first.last>@example.com
cf target -o <org> -s <space>
```

## 2a. Create user-provided-service for config injection
Healthwatch
```
cf cups telegraf-healthwatch-default -p @./config/healthwatch/cups/default_telegraf_config.json
cf cups telegraf-healthwatch-in -p @./config/healthwatch/cups/healthwatch_in_config.json
cf cups telegraf-healthwatch-wavefront-out -p @./config/healthwatch/cups/wavefrontproxy_out_config.json
```
Concourse
```
cf cups telegraf-concourse-default -p @./config/concourse/cups//default_telegraf_config.json
cf cups telegraf-concourse-in -p @./config/concourse/cups/concourse_in_config.json
cf cups telegraf-concourse-wavefront-out -p @./config/concourse/cups/wavefrontproxy_out_config.json
```
vSphere
```
cf cups telegraf-vsphere-default -p @./config/vsphere/cups/default_telegraf_config.json
cf cups telegraf-vsphere-in -p @./config/vsphere/cups/vsphere_in_config.json
cf cups telegraf-vsphere-wavefront-out -p @./config/vsphere/cups/wavefrontproxy_out_config.json
```

## 2b. Or - Update existing UPS for updated configuration
Healthwatch
```
cf uups telegraf-healthwatch-default -p ./config/healthwatch/cups/default_telegraf_config.json
cf uups telegraf-healthwatch-in -p ./config/healthwatch/cups/healthwatch_in_config.json
cf uups telegraf-healthwatch-wavefront-out -p ./config/healthwatch/cups/wavefrontproxy_out_config.json
```
Concourse
```
cf uups telegraf-concourse-default -p ./config/concourse/cups/default_telegraf_config.json
cf uups telegraf-concourse-in -p ./config/concourse/cups/concourse_in_config.json
cf uups telegraf-concourse-wavefront-out -p ./config/concourse/cups/wavefrontproxy_out_config.json
```
vSphere
```
cf uups telegraf-vsphere-default -p ./config/vsphere/cups/default_telegraf_config.json
cf uups telegraf-vsphere-in -p ./config/vsphere/cups/vsphere_in_config.json
cf uups telegraf-vsphere-wavefront-out -p ./config/vsphere/cups/wavefrontproxy_out_config.json

```
## 3. Push the container to CF
```
cf push -f ./config/concourse/manifests/manifest.yml
cf push -f ./config/vsphere/manifests/manifest.yml
cf push -f ./config/healthwatch/manifests/manifest.yml
```
