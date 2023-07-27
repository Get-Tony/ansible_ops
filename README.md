# Ansible Playbook: site.yml

This Ansible playbook is used to configure managed systems.

- Created by: Anthony Pagan
- Created on: 2023-07-22

## Notes

- Firewalld will most likly be removed due to complexity.
- Create a report playbook for tcp_wrapper

## Dependencies

The following roles are used:

- `packages`: Configure packages settings, currently packages packages
- `sshd_config`: Configure `sshd_config` options
- `user_access`: Configure SSH user access
- `firewalld`: Configure `firewalld`

## Tags

The following tags are available:

| Role | Tags | Description |
|------|------|-------------|
| `packages` | `packages` | Install packages |
| `sshd_config` | `sshd_config` | Update the `sshd_config` configuration file |
| `sshd_config` | `sshd_config_backup` | Backup the `sshd_config` configuration file |
| `user_access` | `user_accounts` | Configure user accounts |
| `user_access` | `root_access` | Configure root access |
| `user_access` | `shosts` | Configure `shosts` |
| `firewalld` | `firewalld` | Configure `firewalld` |

Tags can be used to run specific tasks, for example:

```bash
ansible-playbook site.yml --tags "packages,sshd_config"
```

## Variables

- `ssh_keys_folder` (Required for `root_users` and `users`): Folder where the user SSH keys are stored
  - Example:

    ```yaml
    ssh_keys_folder: "{{ playbook_dir }}/files/ssh_keys"
    ```

- `root_shosts_entries`: List of root `shosts` entries to configure
  - Example:

    ```yaml
    root_shosts_entries:
      - hostname: incoming_server1
        user: john
        state: present
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

- `sshd_config_options`: List of `sshd_config` options to configure
  - Example:

    ```yaml
    sshd_config_options:
      - option: AddressFamily
        value: inet
    ```

- `custom_packages`: List of custom packages to install
  - Example:

    ```yaml
    custom_packages:
      - ncdu
    ```

- `firewall_rules`: List of firewall rules to configure
  - Example:

    ```yaml
    firewall_rules:
      - "8443/tcp"
    ```

## Usage

- To use this playbook, run the following command:

```bash
ansible-playbook site.yml
```

- To run specific tasks, use the `--tags` option:

```bash
ansible-playbook site.yml --tags "packages,sshd_config"
```

- To run tasks for specific hosts, use the `-l` option:

```bash
ansible-playbook site.yml -l webserver1
```

## License

This playbook is licensed under the GPL3 License.
