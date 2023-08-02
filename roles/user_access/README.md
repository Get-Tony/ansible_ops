# Ansible Role: user_access

This Ansible role is used to configure user access.

- Created by: Anthony Pagan
- Created on: 2023-07-22

## Tags

The following tags are available:

| Tags | Description |
|------|-------------|
| `user_accounts` | Configure user access |
| `root_access` | Configure root access |
| `shosts` | Configure `shosts` |

## Variables

The following variables are available:

- `root_shosts_entries`: List of root `shosts` entries to configure
  - Example:

    ```yaml
    root_shosts_entries:
      - hostname: incoming_server1
        user: john
        state: present
    ```

- `ssh_keys_folder` (Required for `root_users` and `users`): Folder where the user SSH keys are stored
  - Example:

    ```yaml
    ssh_keys_folder: "{{ playbook_dir }}/files/ssh_keys"
    ```

- `root_users`: List of root users to configure
  - Example:

    ```yaml
    root_users:
        - user_name: user1
          state: present
    ```

- `users`: List of users to configure
  - Example:

    ```yaml
    users:
      - name: user1
        groups:
          - sudo
        state: present
    ```

- `ansible_controllers`: Group Variable. List of Ansible controllers to configure. Required for TCP wrappers.
  - Example:

    ```yaml
    ansible_controllers: 
      - 192.168.59.10

- `tcp_wrapper`: Host Variable. List of TCP wrappers to configure
  - Example:

    ```yaml
    tcp_wrapper:
      sshd:
        - 192.168.50.2
        - 192.168.50.3
      check_mk:
        - 192.168.50.2

## Usage

To use this role, create a playbook similar to the following:

```yaml
---
- hosts: all
  become: true
  roles:
    - user_access
```

## License

This playbook is licensed under the GPL3 License.
