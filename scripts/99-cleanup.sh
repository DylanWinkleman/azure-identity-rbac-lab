#!/usr/bin/env bash
# 99 - Tear down everything created by this lab to avoid charges.
set -uo pipefail   # not -e: keep going even if individual deletes fail

SUB_ID="$(az account show --query id -o tsv)"
RG="rg-identity-lab"
GROUP_NAME="lab-readers"
DOMAIN="<yourtenant>.onmicrosoft.com"

echo "Removing policy assignment..."
az policy assignment delete --name "allowed-locations-lab" \
  --scope "/subscriptions/${SUB_ID}/resourceGroups/${RG}" || true

echo "Removing resource group (this drops RG-scoped role assignments too)..."
az group delete --name "$RG" --yes --no-wait || true

echo "Removing custom role definition..."
az role definition delete --name "VM Operator (Lab)" || true

echo "Removing group and users..."
az ad group delete --group "$GROUP_NAME" || true
az ad user delete --id "alice@${DOMAIN}" || true
az ad user delete --id "bob@${DOMAIN}"   || true

echo "Cleanup complete. Double-check the portal for any stragglers."
