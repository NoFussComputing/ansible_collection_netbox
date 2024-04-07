---
title: GLPI Role
description: No Fuss Computings NetBox Ansible Collection role glpi_netbox
date: 2024-04-07
template: project.html
about: https://gitlab.com/nofusscomputing/projects/ansible/collections/netbox
---

This role as part of the Ansible collection `nofusscomputing.netbox`, contains all of the logic to setup GLPI and NetBox so that the data from NetBox can be synchronized from netbox and kept in sync.


## Setup

To be able to automate the syncing of NetBox to GLPI, both Netbox and GLPI must be setup. to do this run the following play.

``` bash

ansible-playbook nofusscomputing.netbox.glpi --tags setup

```

