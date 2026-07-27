#cloud-config
# 最小ブートストラップのみ。それ以外の構成は ansible/ が担当する。
hostname: ${host_name}
users:
  - name: ${user_name}
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    lock_passwd: false
    passwd: ${user_password}
    ssh_authorized_keys:
%{ for key in ssh_public_keys ~}
      - ${key}
%{ endfor ~}
packages:
  - qemu-guest-agent # Terraform が VM の IP を取得するために必須
runcmd:
  - systemctl enable --now qemu-guest-agent
