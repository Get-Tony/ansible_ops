# Ansible Role: packages

This Ansible role is used to install custom packages. Any packages that are not installable will be skipped.

- Created by: Anthony Pagan
- Created on: 2023-07-22

## Tags

The following tags are available:

| Tags | Description |
|------|-------------|
| `packages` | Install packages |

## Variables

The following variables are available:

- `custom_packages`: List of custom packages to install
  - Example:

    ```yaml
    custom_packages:
      - ncdu
    ```

## Usage

To use this role, create a playbook similar to the following:

```yaml
---
- hosts: all
  become: true
  roles:
    - packages
```

## License

This playbook is licensed under the GPL3 License.
