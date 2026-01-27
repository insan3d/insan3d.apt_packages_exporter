# `apt_packages_exporter` (Ansible role)

Minimal Ansible role that installs the `apt_packages_exporter` script and configures an APT hook to emit metrics for node_exporter textfile collector.

## What it does

- Installs dependencies: `python3-apt`, `python3-prometheus-client`
- Downloads the exporter script
- Installs an `APT` hook that runs the exporter after `apt update` and `dpkg` actions

## Requirements

- Debian-based systems (Debian/Ubuntu)
- Ansible
- `node_exporter` with textfile collector enabled (directory exists and is writable)

## Role variables

| Variable | Description | Default |
|-|-|-|
| `apt_packages_exporter_script_source` | URL of script to download | `https://raw.githubusercontent.com/insan3d/apt_packages_exporter/main/apt_packages_exporter` |
| `apt_packages_exporter_script_filename` | Target script path | `/usr/local/bin/apt_packages_exporter` |
| `apt_packages_exporter_hook_filename` | Path of `APT` hook to manage | `/etc/apt/apt.conf.d/50metrics` |
| `apt_packages_exporter_output` | Text metrics path | `/var/lib/node_exporter/textfile_collector/apt.prom` |

## Example playbook

```yaml
- hosts: all
  become: true
  roles:
    - role: insan3d.apt_packages_exporter
```

## License

MIT
