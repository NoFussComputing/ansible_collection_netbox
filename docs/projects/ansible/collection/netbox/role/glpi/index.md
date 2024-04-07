---
title: GLPI Integration
description: No Fuss Computings NetBox Ansible Collection role glpi_netbox
date: 2024-04-07
template: project.html
about: https://gitlab.com/nofusscomputing/projects/ansible/collections/netbox
---

This role, `netbox_glpi` is part of the Ansible collection `nofusscomputing.netbox` and contains all of the logic to setup GLPI and NetBox so that the data from NetBox can be synchronized to GLPI.


## Features

- Devices Created/Updated within NetBox are synced to GLPI

    !!! info
        Currently the only supported items for updates are those that have had `itil_item_type` field set to `computer`. See [below for further details](index.md#what-gets-synced-from-netbox-to-glpi).


## Requirements

The following requirements to use this collection are as follows:

- GLPI

    NetBox-sync:

    - User that has `read/write` permissions for assets

    - API Application Token `Setup -> General -> API`

    - API Token from the user account mentioned above

    NetBox Setup:

    - User that has `read/write` permissions for custom fields, custom field choices and custom links

- NetBox

    - User with `write` permissions to devices and Virtual Machines

    - ALL devices will need to have `itil_item_type` field set to it's GLPI item type. This will be possible only after running the [setup steps](index.md#setup).


## Setup

To be able to automate the syncing of NetBox to GLPI, both Netbox and GLPI must be setup. to do this run the following play.

``` bash

ansible-playbook nofusscomputing.netbox.glpi \
    --extra-vars "nfc_pb_netbox_netbox_url=https://my-netbox-url" \
    --extra-vars "nfc_pb_netbox_netbox_token=my-netbox-token" \
    --tags setup

```

This play sets up both NetBox for the sync process. Within NetBox custom fields are created, being `itil_id` and `itil_item_type` (GLPI Item Type). These fields will be used to keep track of what GLPI item it is and the item type within GLPI respectively.

Field `itil_id` is used by the system to keep track of the GLPI item ID within netbox. Field `itil_item_type` is used for the end user to set the device GLPI type. This is used to add the item to the correct location within GLPI.

!!! tip
    If you already have your device in GLPI, you can manually set the NetBox items `itil_id` to that of the existing GLPI ID.

A custom link is also created within NetBox as part of the setup. This custom link has a bit of wizardry in that it builds the GLPI link for the device. This only occurs however, when the item has been added to GLPI and there exists a GLPI ID in field `itil_id`


## Events Endpoint

As part of the collection there is an EDA (Event Driven Ansible) endpoint for NetBox to use to post updates to that is the ingress for updating GLPI. This endpoint is available as a docker container or can be setup to run manually with the following command.

``` bash

ansible-rulebook -r nofusscomputing.netbox.glpi --vars "my-vars.yaml"

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

We build and publish a docker container for the EDA endpoint that you can use within your environment. Doesn't matter if it's a simple docker-compose or kubernetes setup.

The container already automagically starts an EDA rulebook that is listening for connections from NetBox. To setup the container you must configure the rulebook via a vars file. Mount your a vars file to path `/root/var.yaml`. The content of this vars file is mentioned in the previous section.


## Default Variables

``` yaml title="defaults/main.yaml" linenums="1"

--8<-- "roles/netbox_glpi/defaults/main.yaml"

```


## What gets synced from NetBox to GLPI

- Device with its type set to `computer`.

- Device with its type set to `networkequipment`.

    The following fields are kept in sync:

    - Name

    - Serial Number

- Virtual Machine with its type set to `computer`.

    The following fields are kept in sync:

    - Name
