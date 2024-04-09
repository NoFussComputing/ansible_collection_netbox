## 0.1.0-a1 (2024-04-07)

### Feat

- **GLPI**: sync asset number to GLPI
- **glpi-docker**: Scheduled job to sync GLPI Entities default=15 mins
- **glpi**: Ability to set GLPI Entity for item in NetBox
- **glpi**: add a gate to eda to prevent processing the webhook from updating the glpi_id
- **glpi**: when posting back to netbox use the url from the event packet
- **glpi**: payload may contain jinja, sanitize
- **glpi**: if the device has no serial number set, dont sync

### Fix

- **netbox**: ensure automagic link to GLPI available for virtual machines
- **docker**: vars file requires '@` prefixed
- **glpi**: use correct field name for netbox custom field
- **glpi**: correct logic to ensure serial number is present

### Refactor

- **netbox**: place choice set logic in its own task file
- **glpi**: don't show items in netbox GLPI Item Type not yet supported

## 0.0.1 (2024-04-06)
