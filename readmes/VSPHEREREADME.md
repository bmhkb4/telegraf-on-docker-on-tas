Refer to the [main readme](../README.md) if you are lost

This module uses the [vsphere plugin](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/vsphere) for telegraf

**Special Note** This one is sort of a work-in-progress, you'll notice we don't actually use the environment variable in the .conf file for the only actually usable user-provided-service key:pair

# VSPHERE Specific Prereqs
***
## 1. Create Read Only Admin Account in vCenter

Via active directory or local account

**Note:** Make sure it has access to [all these config options in vCenter](../templates/vsphere_in.conf#L5-L88)

## 2. Inject the RO Account/Password in via whatever Cred Mgmt stuff you have

See [here](../templates/vsphere_in.conf#L2-L4) and [this](../bin/telegraf_vsphere.sh#L2-L4) for an example of how we reference these

**Special Note** Normally, all of [that](../templates/vsphere_in.conf#L5-L90) configuration would be in an [environment specific config file](../config/vsphere/cups/vsphere_in_config.json), but because of the way we are mapping Environment Variables, some are hard coded in the template =(
