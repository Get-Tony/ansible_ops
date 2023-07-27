# Ansible Role: firewalld

This Ansible Role is used to configure firewalld rules. Note that this role
is hardcoded to keep the SSH port open, even if a rule is defined to close
it.

- Created by: Anthony Pagan
- Created on: 2023-07-22

## Warning

This role is not intended to be used on a system that is already configured
with firewalld rules. This role will overwrite any existing rules.

This role **will install and enable firewalld** if it is not already installed
and enabled.

## Tags

The following tags are available:

| Tags | Description |
|------|-------------|
| `firewalld` | Configure `firewalld` |

## Variables

The following variables are available:

- `firewall_rules`: List of firewall rules to configure
  - Example:

    ```yaml
    firewall_rules:
      - "8443/tcp"
    ```

## Usage

To use this role, create a playbook similar to the following:

```yaml
---
- hosts: all
  become: true
  roles:
    - firewalld
```

## License

This playbook is licensed under the GPL3 License.
