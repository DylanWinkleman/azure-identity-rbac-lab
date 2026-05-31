# Azure Identity & RBAC Lab

> Hands-on lab demonstrating identity and access management in Microsoft Azure:
> Entra ID users & groups, built-in and custom RBAC roles, Azure Policy, and
> organization with management groups and tags.
>
> Maps to the **AZ-104 — Identity & Governance** exam domain (15–20%).

![Status](https://img.shields.io/badge/status-in%20progress-yellow)
![Azure](https://img.shields.io/badge/Azure-Entra%20ID%20%7C%20RBAC%20%7C%20Policy-0078D4)

---

## 🎯 What this lab demonstrates

The ability to control **who can do what** in an Azure environment:

- Provisioning identities (users) and grouping them for scalable access management
- Granting least-privilege access with **built-in RBAC roles** at the right scope
- Authoring a **custom RBAC role** with a narrow, purpose-built permission set
- Enforcing organizational guardrails with **Azure Policy**
- Structuring resources for governance using **management groups** and **tags**

## 🧰 Azure services used

Microsoft Entra ID · Azure RBAC · Custom Roles · Azure Policy · Management Groups · Resource Tags

---

## 📋 Build log

> Fill each section in as you complete it. Drop screenshots in `screenshots/` and
> reference them inline. The goal is that someone reading this repo can see *exactly*
> what you did and that it works.

### 1. Entra ID users & groups
**What I did:**
- Created `<N>` Entra ID users (e.g. `alice@…`, `bob@…`)
- Created group(s): `<group-name>` and added members

**Why it matters:** assigning access to *groups* instead of individual users is the scalable, real-world pattern.

```bash
# See scripts/01-users-and-groups.sh for the CLI version
```

![Users and groups](screenshots/01-users-and-groups.png)

---

### 2. Built-in RBAC role assignments
**What I did:**
- Assigned **Reader** to `<group>` at `<subscription | resource group>` scope
- Assigned **Contributor** to `<group/user>` at `<resource group>` scope

**Key concept:** *role assignment = security principal + role definition + scope.* Scope inherits downward (management group → subscription → resource group → resource).

![RBAC assignments](screenshots/02-rbac-assignments.png)

---

### 3. Custom RBAC role
**What I did:**
- Authored a custom role `<role-name>` granting only `<actions>` (e.g. start/restart VMs but not delete)
- Assigned it at `<scope>` and verified the principal could do *only* the intended actions

See [`custom-roles/`](custom-roles/) for the role definition JSON.

![Custom role](screenshots/03-custom-role.png)

---

### 4. Azure Policy
**What I did:**
- Assigned policy: `<Allowed locations | Require a tag on resources>`
- Verified enforcement by attempting a non-compliant deployment (denied / flagged)

![Azure Policy](screenshots/04-azure-policy.png)

---

### 5. Management groups & tags
**What I did:**
- Created management group `<name>` and placed the subscription under it
- Applied tags (`env=lab`, `owner=dylan`, `costcenter=…`) for organization/cost tracking

![Management groups & tags](screenshots/05-mgmt-groups-tags.png)

---

## 🧹 Cleanup (cost discipline)

```bash
# Remove role assignments, policy assignment, custom role, users/groups, and the lab RG
# See scripts/99-cleanup.sh
```

> Always tear down lab resources when finished to avoid charges.

---

## 🔗 Related

- AZ-104 study tracker (Obsidian) — Identity & Governance domain
- Companion labs: `azure-vm-networking-lab`, `azure-storage-sas-lab`, `azure-dns-static-web-app-lab`

## 📝 Résumé bullet

> Built an Azure identity & access-management lab: provisioned Entra ID users/groups,
> applied least-privilege access with built-in and **custom RBAC roles** scoped per
> resource group, and enforced governance guardrails with **Azure Policy**,
> management groups, and tagging.
