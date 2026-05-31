#!/usr/bin/env bash
# 02 - Assign built-in RBAC roles at subscription / resource-group scope.
set -euo pipefail

SUB_ID="$(az account show --query id -o tsv)"
RG="rg-identity-lab"
LOCATION="eastus"
GROUP_NAME="lab-readers"

# Create the lab resource group we'll scope Contributor to
az group create --name "$RG" --location "$LOCATION"

GROUP_ID="$(az ad group show --group "$GROUP_NAME" --query id -o tsv)"

# Reader at subscription scope (broad, read-only)
az role assignment create \
  --assignee-object-id "$GROUP_ID" --assignee-principal-type Group \
  --role "Reader" \
  --scope "/subscriptions/${SUB_ID}"

# Contributor at resource-group scope (narrow, write within one RG)
az role assignment create \
  --assignee-object-id "$GROUP_ID" --assignee-principal-type Group \
  --role "Contributor" \
  --scope "/subscriptions/${SUB_ID}/resourceGroups/${RG}"

echo "Assignments created. Verify:"
az role assignment list --scope "/subscriptions/${SUB_ID}/resourceGroups/${RG}" -o table
