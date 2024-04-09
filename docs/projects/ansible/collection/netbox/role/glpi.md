---
title: GLPI Integration
description: No Fuss Computings NetBox Ansible Collection role glpi_netbox
date: 2024-04-07
template: project.html
about: https://gitlab.com/nofusscomputing/projects/ansible/collections/netbox
---

This role, `netbox_glpi` is part of the Ansible collection `nofusscomputing.netbox` and contains all of the logic to setup GLPI and NetBox so that the data from NetBox can be synchronized to GLPI.

There are two methods available to take advantage of this role: running the playbooks and rulebook manually or by deploying the docker container we publish. The docker container is intended to be the all-in-one solution for integrating NetBox with GLPI. The container is published to Docker Hub and can be fetched by running `docker pull nofusscomputing/netbox-glpi:dev`.


## Features

- Devices Created/Updated within NetBox are synced to GLPI

    !!! info
        Currently the only supported items for updates are those that have had `itil_item_type` field set to `computer`. See [below for further details](index.md#what-gets-synced-from-netbox-to-glpi).

- Entity Sync from GLPI

- Manufacturer Sync from Netbox

- NetBox Status' added to GLPI


## Requirements

The following requirements to use this collection are as follows:

- GLPI

    NetBox-sync:

    - User that has `read/write` permissions for assets and to All entities within GLPI

    - API Application Token `Setup -> General -> API`

    - API Token from the user account mentioned above

    NetBox Setup:

    - User that has `read/write` permissions for custom fields, custom field choices and custom links

    GLPI Setup:

    - User has access to add Status' to global drop downs

    - User has access to add Manufacturers to global drop downs

- NetBox

    - User with `write` permissions to devices and Virtual Machines

    - ALL items for sync to GLPI need to have fields `GLPI Item Type` and `GLPI Entity` set. Without this the item will not be added to GLPI. This will be possible only after running the [setup steps](index.md#setup).


## Setup

To be able to automate the syncing of NetBox to GLPI, both Netbox and GLPI must be setup. to do this run the following play.

``` bash

ansible-playbook nofusscomputing.netbox.glpi  \
    --extra-vars "nfc_pb_netbox_netbox_url=https://my-netbox-url" \
    --extra-vars "nfc_pb_netbox_netbox_token=my-netbox-token" \
    --extra-vars "nfc_pb_netbox_glpi_url_glpi=https://my-glpi-url" \
    --extra-vars "nfc_pb_netbox_itam_glpi_app_token=my-glpi-app-token" \
    --extra-vars "nfc_pb_netbox_itam_glpi_user_token=my-glpi-api-user-token"
    --tags setup

```

This play sets up both NetBox and GLPI for the sync process.


### NetBox

The following items are setup/created in netbox as part of the setup process:

- Custom field `itil_id` is used by the system to keep track of the GLPI item ID within netbox. 

- Custom field `itil_item_type` is used for the end user to set the device GLPI type. This is used to add the item to the correct location within GLPI.

    !!! tip
        If you already have your device in GLPI, you can manually set the NetBox items `itil_id` to that of the existing GLPI ID.

- Custom field `UUID` for computers and virtual machines. This field is the machines UUID.

- A custom link is also created within NetBox as part of the setup. This custom link has a bit of wizardry in that it builds the GLPI link for the device. This only occurs however, when the item has been added to GLPI and there exists a GLPI ID in field `itil_id`


### GLPI

As Part of the setup process the default device status' from NetBox are added to the root entity (`recusive=yes`) within GLPI. This Dropdown field will be used for the device when it is synced from Netbox so that the Status between the two systems remain in sync. So as not to require additional permissions for the API client, the status' are setup within the default vars as a list under key `nfc_role_netbox_glpi_device_status`. This enables you to update the available status' if you use a custom set within Netbox. This process unfortunately, is manual. If you update the status' list, don't forget to run the setup job again.


## GLPI/NetBox Sync

A play exists with the purpose of syncing items between GLPI and NetBox. The purpose of this play is to keep fields that have information from the other system in sync. To run, use the following command.

``` bash

ansible-playbook nofusscomputing.netbox.sync \
    --extra-vars "nfc_pb_netbox_netbox_url=https://my-netbox-url" \
    --extra-vars "nfc_pb_netbox_netbox_token=my-netbox-token" \
    --extra-vars "nfc_pb_netbox_glpi_url_glpi=https://my-glpi-url" \
    --extra-vars "nfc_pb_netbox_itam_glpi_app_token=my-glpi-app-token" \
    --extra-vars "nfc_pb_netbox_itam_glpi_user_token=my-glpi-api-user-token"

```

This playbook will create within NetBox, a custom field choices containing ALL of the GLPI Entities and add a custom field for the end user to select the GLPI entity the item should be added to. Within GLPI all of the manufacturers found in NetBox are added to GLPI. This play can be run as often as you would like as it will update GLPI/Netbox with any updated items.


## Events Endpoint

As part of the collection there is an EDA (Event Driven Ansible) rulebook for NetBox to use to post updates to that is the ingress for updating GLPI. This endpoint is available as a docker container or can be setup to run manually with the following command.

``` bash

ansible-rulebook -r nofusscomputing.netbox.entities --vars "my-vars.yaml"

```

the following variables are required for the rulebook.

``` yaml
nofusscomputing_netbox_eda_port: 5000           # Optional, Integer. the port number the EDA rulebook will listen on.
nofusscomputing_netbox_api_username: ansible    # Optional, string. Username of the API user. Recommend setting to prevent update loops.

# See default variables below for explanation
nfc_pb_netbox_netbox_token:
nfc_pb_netbox_netbox_url:
nfc_pb_netbox_glpi_url_glpi:
nfc_pb_netbox_itam_glpi_app_token:
nfc_pb_netbox_itam_glpi_user_token:

```


### Docker Setup

We build and publish a docker container for the EDA rulebook and sync that you can use within your environment. Doesn't matter if it's a simple docker-compose or kubernetes setup.

The container already automagically starts an EDA rulebook that is listening for connections from NetBox. To setup the container you must configure the rulebook via a vars file. Mount your a vars file to path `/root/var.yaml`. The content of this vars file is mentioned in the previous section. There is also a cronjob within the container that synchronizes the GLPI entites to NetBox. By default the job will run every 15 mins. if you wish to change this mount a new cron file to path `/etc/cron.d/glpi-sync` within the container.

``` crontab title="/etc/cron.d/glpi-sync"

--8<-- "includes/etc/cron.d/glpi-sync"

```
_Default cron file for sync with NetBox._

Once you have the container running all available playbooks can be run from within the the container. i.e. `docker run -ti <container name> ansible-playbook nofusscomputing.netbox.glpi --tags setup` 


#### Updating the container

To update the container to a newer version, the following steps should be followed:

1. pull the new container

1. relaunch the deployment using the new container

1. run the setup command `docker run -ti <container name> ansible-playbook nofusscomputing.netbox.glpi --tags setup`


## Default Variables

``` yaml title="defaults/main.yaml" linenums="1"

--8<-- "roles/netbox_glpi/defaults/main.yaml"

```


## What gets synced from NetBox to GLPI

- Device with its type set to `computer`.

    Device with its type set to `networkequipment`.

    The following fields are kept in sync:

    - Asset Number

    - Name

    - Manufacturer

    - Serial Number

    - Selected GLPI Entity

    - Status

    - UUID


- Virtual Machine with its type set to `computer`.

    The following fields are kept in sync:

    - Name

    - Selected GLPI Entity

    - UUID
