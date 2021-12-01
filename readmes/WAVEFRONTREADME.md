Refer to the [main readme](../README.md) if you are lost

This module uses the [wavefront output plugin](https://github.com/influxdata/telegraf/tree/master/plugins/outputs/wavefront) for telegraf

# WAVEFRONT Specific Prereqs
***
## 1. You must have a [Wavefront Proxy](https://docs.wavefront.com/proxies.html) configured

## 2. Inject the HOST:PORT in as Environment Variables (User-provided Service)

See [here](./templates/wavefrontproxy_out.conf) and [this](./bin/telegraf_wavefront.sh) for an example of how we reference these

