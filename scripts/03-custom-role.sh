#!/usr/bin/env bash
# 03 - Create and assign a custom RBAC role from custom-roles/vm-operator.json
set -euo pipefail

SUB_ID="$(az account show --query id -o tsv)"
DEF="custom-roles/vm-operator.json"

# Substitute the subscription id into the assignable scope
TMP="$(mktemp)"
sed "s/<SUBSCRIPTION_ID>/${SUB_ID}/g" "$DEF" > "$TMP"

az role definition create --role-definition "$TMP"
rm -f "$TMP"

echo "Custom role created. List to confirm:"
az role definition list --custom-role-only true --query "[].roleName" -o table
