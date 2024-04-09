## 0.2.0 (2024-04-09)

### Feat

- **eda**: set itam update play run to v1
- **netbox-glpi**: deploy container to kubernetes and setup
- **glpi-docker**: For all playbooks automagic load vars file
- **glpi-docker**: dont install nmap

### Fix

- **glpi-docker**: set port to 5000 as was the intent
- **eda**: ensure  EDA collection is installed

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

## 0.0.1 (2024-04-06)
