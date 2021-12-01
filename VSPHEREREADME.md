Refer to the [main readme](./README.md) if you are lost

# VSPHERE Specific Prereqs
***
## 1. Create Read Only Admin Account in vCenter

Via active directory or local account

**Note:** Make sure it has access to [all these config options in vCenter](./templates/vsphere_in.conf#5-88)

## 2. Inject the RO Account/Password in via whatever Cred Mgmt stuff you have

See [here](./templates/vsphere_in.conf) and [this](./bin/telegraf_vsphere.sh) for an example of how we reference these

**Special Note** Normally, all of that configuration would be in an [environment specific config file](./config/vsphere/vsphere_in_config.json), but because of the way we are mapping Environment Variables, some hard hard coded in the template =(