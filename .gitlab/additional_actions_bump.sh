#!/bin/sh

sed -E "/tag: /s/[0-9]+\.[0-9]+\.[0-9]+[\-]?[a-z]?[0-9]+?/$(cz version --project)/" -i roles/netbox_glpi/defaults/main.yaml;

git add roles/netbox_glpi/defaults/main.yaml;

git status;
