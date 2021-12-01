Refer to the [main readme](./README.md) if you are lost

# * Concourse Specific Prereqs*
## 1. Turn on Prometheus endpoint for Concourse
Reference [this](https://concourse-ci.org/metrics.html) or if Concourse is deployed through bosh, use an [ops file](https://github.com/concourse/concourse-bosh-deployment/blob/master/cluster/operations/prometheus.yml)

## 2. Populate Concourse Config with Prometheus endpoint
Populate [json](config/concourse_in_config.json)

Note: If you use cert/key for access you can steal some logic from other use cases
* [Healthwatch](./HEALTHWATCHREADME.md)
* [Vsphere](./VSPHEREREADME.md)

