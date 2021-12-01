Refer to the [main readme](../README.md) if you are lost

This module uses the regular old [prometheus plugin](https://github.com/influxdata/telegraf/blob/master/plugins/inputs/prometheus/README.md) for telegraf

# * Healthwatch Specific Prereqs*
## 1. Gather Cert and Key
These are fine to be copy pasted directly into the config

![Healthwatch Cert and Key](./images/healthwatchcertandkey.PNG)

## 2. Gather Ops Mgr CA
### Enter Ops Mgr Settings Menu
![Healthwatch CA1](./images/healthwatchca1.PNG)

### Download Root CA to file (/tmp/ca)
![Healthwatch CA2](./images/healthwatchca2.PNG)

### Correct format for CA
```
awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' /tmp/ca
```
## 4. Gather Static IPs of the exporters
![Healthwatch Static IPs](./images/healthwatchstaticips.PNG)

## 5. Update configuration json

Example [here](./config/healthwatch_in_config.json)

