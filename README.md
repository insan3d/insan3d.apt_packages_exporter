# `apt_packages_exporter` (Ansible role)

Minimal Ansible role that installs the `apt_packages_exporter` script and configures an APT hook to emit metrics for
node_exporter textfile collector.

## What it does

- Installs dependencies: `python3-apt`, `python3-prometheus-client`
- Downloads the exporter script from a pinned Git ref
- Ensures the textfile collector output directory exists
- Installs an `APT` hook that runs the exporter after `apt update` and `dpkg` actions

## Requirements

- Debian 13 (trixie)
- Ansible
- `node_exporter` with textfile collector enabled

## Role variables

Defaults are defined in [defaults/main.yml](defaults/main.yml).

| Variable                                | Description                                       |
| --------------------------------------- | ------------------------------------------------- |
| `apt_packages_exporter_script_ref`      | Git ref of the script                             |
| `apt_packages_exporter_script_source`   | Script download URL                               |
| `apt_packages_exporter_script_checksum` | Checksum matching the selected ref and source URL |
| `apt_packages_exporter_script_filename` | Target script path                                |
| `apt_packages_exporter_hook_filename`   | Managed APT hook path                             |
| `apt_packages_exporter_output`          | Textfile metrics path                             |

The default checksum matches the script at ref `1.0-4`. When changing the ref or source URL, provide its matching
checksum. With an unchanged script, check mode compares the checksum locally without an HTTP request. An empty checksum
disables verification and can produce false `changed` results.

## Example playbook

```yaml
- name: Install the APT package metrics exporter
  hosts: all

  roles:
    - role: insan3d.apt_packages_exporter
```

## License

MIT
