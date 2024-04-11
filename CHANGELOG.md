## 0.3.0 (2024-04-11)

### Feat

- **glpi**: search by serial number then name within GLPI if no ID present
- **glpi**: if GLPI ID present update that item

## 0.2.1 (2024-04-10)

### Fix

- **glpi**: manufacturer sync not to require run tags
- **choice_set**: dont attempt to update choice_set when creating
- **netbox-glpi**: correct kubernetes manifests extension to .yaml.j2
- **glpi**: session init and kill to use correct no_log var
- **glpi**: api searches must be url encoded
- **playbooks**: ensure vars file loads when tags specified

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

### Fix

- **glpi**: create/update must create new var when updating
- **netbox**: ensure automagic link to GLPI available for virtual machines
- **docker**: vars file requires '@` prefixed

### Refactor

- move manufacturer sync to sync playbook
- movie eneites sync play to a play called sync
- **netbox_glpi**: rearrange tasks based off of the task
- **netbox_setup**: place netbox setup tasks in place that makes more sense

## 0.0.1 (2024-04-06)
