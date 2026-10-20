# `apt_packages_exporter` (Ansible role)

Minimal Ansible role that installs the `apt_packages_exporter` script and configures an APT hook to emit metrics for node_exporter textfile collector.

## What it does

- Installs dependencies: `python3-apt`, `python3-prometheus-client`
- Downloads the exporter script from a pinned Git ref
- Ensures the textfile collector output directory exists
- Installs an `APT` hook that runs the exporter after `apt update` and `dpkg` actions

## Requirements

- Debian-based systems (Debian/Ubuntu)
- Ansible
- `node_exporter` with textfile collector enabled

## Role variables

| Variable | Description | Default |
|-|-|-|
| `apt_packages_exporter_script_ref` | Git ref to download script from | `1.0-4` |
| `apt_packages_exporter_script_source` | URL of script to download | `https://raw.githubusercontent.com/insan3d/apt_packages_exporter/1.0-4/apt_packages_exporter` |
| `apt_packages_exporter_script_checksum` | Script checksum; override together with the ref or source URL | SHA256 of `1.0-4` |
| `apt_packages_exporter_script_filename` | Target script path | `/usr/local/bin/apt-packages-exporter` |
| `apt_packages_exporter_hook_filename` | Path of `APT` hook to manage | `/etc/apt/apt.conf.d/50metrics` |
| `apt_packages_exporter_output` | Text metrics path | `/var/lib/node_exporter/textfile_collector/apt.prom` |

The default checksum matches the script at ref `1.0-4`. When changing the ref or source URL,
provide its matching checksum. With an unchanged script, check mode compares the checksum locally
without an HTTP request. An empty checksum disables verification and can produce false `changed` results.

## Example playbook

```yaml
- hosts: all
  become: true
  roles:
    - role: insan3d.apt_packages_exporter
```

## License

MIT
