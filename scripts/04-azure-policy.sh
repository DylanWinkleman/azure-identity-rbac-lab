#!/usr/bin/env bash
# 04 - Assign a built-in "Allowed locations" policy at the resource-group scope.
set -euo pipefail

SUB_ID="$(az account show --query id -o tsv)"
RG="rg-identity-lab"

# Built-in "Allowed locations" policy definition id
POLICY_ID="/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"

az policy assignment create \
  --name "allowed-locations-lab" \
  --display-name "Allowed locations (lab) - eastus only" \
  --policy "$POLICY_ID" \
  --scope "/subscriptions/${SUB_ID}/resourceGroups/${RG}" \
  --params '{ "listOfAllowedLocations": { "value": [ "eastus" ] } }'

echo "Policy assigned. Test it by trying to create a resource in another region (should be denied)."
