---
title: NetBox
description: No Fuss Computings NetBox Ansible Collection
date: 2024-04-06
template: project.html
about: https://gitlab.com/nofusscomputing/projects/ansible/collections/netbox
---

<span style="text-align: center;">

![Project Status - Active](https://img.shields.io/badge/Project%20Status-Active-green?logo=gitlab&style=plastic)


![branch release version](https://img.shields.io/badge/dynamic/yaml?color=ff782e&logo=gitlab&style=plastic&label=Stable%20Release&query=%24.commitizen.version&url=https%3A//gitlab.com/nofusscomputing/projects/ansible/collections/netbox%2F-%2Fraw%2Fmaster%2F.cz.yaml) 
![branch release version](https://img.shields.io/badge/dynamic/yaml?color=ff782e&logo=gitlab&style=plastic&label=Dev%20Release&query=%24.commitizen.version&url=https%3A//gitlab.com/nofusscomputing/projects/ansible/collections/netbox%2F-%2Fraw%2Fdevelopment%2F.cz.yaml)


[![Downloads](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fgalaxy.ansible.com%2Fapi%2Fv3%2Fplugin%2Fansible%2Fcontent%2Fpublished%2Fcollections%2Findex%2Fnofusscomputing%2Fnetbox%2F&query=%24.download_count&style=plastic&logo=ansible&logoColor=white&label=Galaxy%20Downloads&labelColor=black&color=cyan)](https://galaxy.ansible.com/ui/repo/published/nofusscomputing/netbox/)
[![Docker Pulls (netbox-glpi)](https://img.shields.io/docker/pulls/nofusscomputing/netbox-glpi?style=plastic&logo=docker&logoColor=0db7ed&color=0db7ed&label=Docker%20Pulls%20(netbox-glpi))](https://hub.docker.com/r/nofusscomputing/netbox-glpi)


</span>

The intent of this collection is to enable integration from NetBox to other systems; With the sole focus being on NetBox being the Single Source of Truth. This collection is published on Ansible Galaxy and can be installed by running `ansible-galaxy collection install nofusscomputing.netbox`.


## Requirements

Any item that has specific requirements will be notated within its documentation. Items covered under the requirements heading are those items that without the software wont function as intended.


## Features

This feature list is for the collection as a whole. Each feature listed here does have a feature list itself. Each listed item should be looked at as a feature set.

- [GLPI Integration](role/glpi.md)

- Foreman Integration _[See Issue #1](https://gitlab.com/nofusscomputing/projects/ansible/collections/netbox/-/issues/1)_
