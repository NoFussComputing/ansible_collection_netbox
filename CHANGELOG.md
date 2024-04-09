## 0.1.0 (2024-04-09)

### Feat

- **glpi**: Sync Device Manufacturer with GLPI
- **glpi**: fetch manufactures from netbox and add to GLPI
- **glpi**: sync item status to glpi from netbox
- **glpi**: As part of setup, add device status to GLPI that Netbox uses.
- **glpi**: netbox UUID Custom filed with sync to GLPI
- **GLPI**: sync asset number to GLPI
- **glpi-docker**: Scheduled job to sync GLPI Entities default=15 mins
- **glpi**: Ability to set GLPI Entity for item in NetBox
- **glpi**: add a gate to eda to prevent processing the webhook from updating the glpi_id

### Fix

- **glpi**: create/update must create new var when updating
- **netbox**: ensure automagic link to GLPI available for virtual machines
- **docker**: vars file requires '@` prefixed

### Refactor

- move manufacturer sync to sync playbook
- movie eneites sync play to a play called sync
- **netbox_glpi**: rearrange tasks based off of the task
- **netbox_setup**: place netbox setup tasks in place that makes more sense
- **netbox**: place choice set logic in its own task file
- **glpi**: don't show items in netbox GLPI Item Type not yet supported

## 0.0.1 (2024-04-06)
