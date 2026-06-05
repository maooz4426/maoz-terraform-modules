#cloud-config
users:
  - name: ${name}
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    lock_passwd: false
    passwd: ${user_password}
    ssh_authorized_keys:
      - ${ssh_public_key}
packages:
%{ for package in packages ~}
  - ${package}
%{ endfor ~}
runcmd:
%{ for cmd in runcmd ~}
  - |
    ${indent(4, cmd)}
%{ endfor ~}

