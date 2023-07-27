# Ansible Role: sshd_config

This Ansible role is used to configure specified entries in the `sshd_config` configuration file.

- Created by: Anthony Pagan
- Created on: 2023-07-22

## Tags

The following tags are available:

| Tags | Description |
|------|-------------|
| `sshd_config` | Update the `sshd_config` configuration file |
| `sshd_config_backup` | Backup the `sshd_config` configuration file |

## Variables

The following variables are available:

- `sshd_config_options`: List of `sshd_config` options to configure
  - Example:

    ```yaml
    sshd_config_options:
      - option: AddressFamily
        value: inet
    ```

## Usage

To use this role, create a playbook similar to the following:

```yaml
---
- hosts: all
  become: true
  roles:
    - sshd_config
```

## License

This playbook is licensed under the GPL3 License.
