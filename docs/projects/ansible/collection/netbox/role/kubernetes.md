---
title: Kubernetes Deployment
description: No Fuss Computings NetBox Ansible Collection role netbox_kubernetes
date: 2024-04-11
template: project.html
about: https://gitlab.com/nofusscomputing/projects/ansible/collections/netbox
---

This role, `netbox_kubernetes` is part of the Ansible collection `nofusscomputing.netbox` and contains all of the logic to configure and deploy Netbox to Kubernetes.

To deploy NetBox to kubernetes, run the following playbook.

``` bash

ansible-playbook -i inventory/ --limit <your hostname> nofusscomputing.netbox.kubernetes

```


## Features

- NetBox Deployment

- NetBox Service

- PVC for Netbox Data

- Redis Deployment

- Deployment of the [NetBox-GLPI Integration](glpi.md#kubernetes-deployment)

    !!! note
        Deploying the netbox-glpi integration via this role, regardless of your custom variables. Sets the following variables to match this roles variables: Intstance Name, Namespace, and netbox API URL.


## Kubernetes Manifests

All manifests within this role, are Jinja Templates. They obtain their variables from `defaults/main.yaml`

=== "configmap.yaml.j2"

    ``` yaml title="configmap.yaml.j2" linenums="1"

    --8<-- "roles/netbox_kubernetes/templates/configmap.yaml.j2"

    ```

=== "deployment-redis.yaml.j2"

    ``` yaml title="deployment-redis.yaml.j2" linenums="1"

    --8<-- "roles/netbox_kubernetes/templates/deployment-redis.yaml.j2"

    ```

=== "deployment.yaml.j2"

    ``` yaml title="deployment.yaml.j2" linenums="1"

    --8<-- "roles/netbox_kubernetes/templates/deployment.yaml.j2"

    ```

=== "ingress.yaml.j2"

    ``` yaml title="ingress.yaml.j2" linenums="1"

    --8<-- "roles/netbox_kubernetes/templates/ingress.yaml.j2"

    ```

=== "pvc.yaml.j2"

    ``` yaml title="pvc.yaml.j2" linenums="1"

    --8<-- "roles/netbox_kubernetes/templates/pvc.yaml.j2"

    ```

=== "secret.yaml.j2"

    ``` yaml title="secret.yaml.j2" linenums="1"

    --8<-- "roles/netbox_kubernetes/templates/secret.yaml.j2"

    ```

=== "service-redis.yaml.j2"

    ``` yaml title="service-redis.yaml.j2" linenums="1"

    --8<-- "roles/netbox_kubernetes/templates/service-redis.yaml.j2"

    ```

=== "service.yaml.j2"

    ``` yaml title="service.yaml.j2" linenums="1"

    --8<-- "roles/netbox_kubernetes/templates/service.yaml.j2"

    ```


## Default Variables

As part of this role variables that are considered secrets can be set via environmental variables on the Ansible controller. This allows these values to be set via an AWX credential. The available variables are:

- `POSTGRES_HOST` = `nfc_role_netbox_kubernetes_database_host`

- `POSTGRES_PORT` = `nfc_role_netbox_kubernetes_database_port`

- `POSTGRES_USER` = `nfc_role_netbox_kubernetes_database_user`

- `POSTGRES_PASSWORD` = `nfc_role_netbox_kubernetes_database_password`

- `REDIS_HOST` = `nfc_role_netbox_kubernetes_redis_host`

- `REDIS_PORT` = `nfc_role_netbox_kubernetes_redis_port`

- `REDIS_USER` = `nfc_role_netbox_kubernetes_redis_username`

- `REDIS_PASSWORD` = `nfc_role_netbox_kubernetes_redis_password`

The above listed variables will default to the value within your inventory if not set via an environmental variable.

``` yaml title="defaults/main.yaml" linenums="1"

--8<-- "roles/netbox_kubernetes/defaults/main.yml"

```
