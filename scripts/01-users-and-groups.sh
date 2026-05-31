#!/usr/bin/env bash
# 01 - Create Entra ID users and a group, then add members.
# Requires: az login  (and a tenant where you can create users)
set -euo pipefail

# --- EDIT THESE ---
DOMAIN="<yourtenant>.onmicrosoft.com"   # az account show --query 'user.name'
PASSWORD="<StrongTempPassw0rd!>"         # users will be forced to change at next login
GROUP_NAME="lab-readers"
# ------------------

create_user () {
  local display="$1" upn="$2"
  az ad user create \
    --display-name "$display" \
    --user-principal-name "$upn" \
    --password "$PASSWORD" \
    --force-change-password-next-sign-in true
  echo "Created user: $upn"
}

create_user "Alice Lab"  "alice@${DOMAIN}"
create_user "Bob Lab"    "bob@${DOMAIN}"

# Create a security group and add the users
az ad group create --display-name "$GROUP_NAME" --mail-nickname "$GROUP_NAME"
az ad group member add --group "$GROUP_NAME" --member-id "$(az ad user show --id alice@${DOMAIN} --query id -o tsv)"
az ad group member add --group "$GROUP_NAME" --member-id "$(az ad user show --id bob@${DOMAIN}   --query id -o tsv)"

echo "Done. Group '$GROUP_NAME' created with members."
