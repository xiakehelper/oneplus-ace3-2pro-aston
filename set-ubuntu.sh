#!/bin/sh
set -e


# 1、确保systemd不认为它在运行
[ ! -d /run/systemd ] && exit 0
rm -Rf /run/systemd/system
chattr +i /run/systemd


# 移除不可变标志
[ ! -d /run/systemd ] && exit 0
chattr -i /run/systemd


# 创建Ubuntu用户账户
getent group sudo >/dev/null 2>&1 || groupadd --system sudo
useradd --create-home -s /bin/bash -G sudo -U ubuntu


# 启用 systemd-networkd
systemctl enable systemd-networkd

# 禁用UA连接
systemctl mask ua-auto-attach


# Ensure /etc/resolv.conf is symlinked to /run/systemd/resolve/stub-resolv.conf
#ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf


# 确保区域设置已构建且功能正常
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8

# Cleanup underlying /run
mount -o bind / /mnt
rm -rf /mnt/run/*
umount /mnt

# 清理临时shadow路径
rm /etc/*-

#TARGET="arm64"
#update-grub
# This will create EFI/BOOT
#grub-install --uefi-secure-boot --target="${TARGET}-efi" --no-nvram --removable
# This will create EFI/ubuntu
#grub-install --uefi-secure-boot --target="${TARGET}-efi" --no-nvram
#update-grub
#sed -i "s#root=[^ ]*#root=${DISTROBUILDER_ROOT_UUID}#g" /boot/grub/grub.cfg

# 关闭定位服务
systemctl mask geoclue.service

# 时区
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/UTC /etc/localtime
echo UTC > /etc/timezone

# 区域
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

# 用户
USERNAME="ubuntu"
useradd ${USERNAME} -s /bin/bash -m -U -G adm,video,users

cat << EOF > /etc/gdm3/custom.conf
[daemon]
AutomaticLogin=${USERNAME}
AutomaticLoginEnable=true
EOF

# 禁用欢迎导览
cat << EOF > /home/ubuntu/firstboot.sh
#!/bin/sh

set -e

# Disable automatic screensaver lock
gsettings set org.gnome.desktop.screensaver lock-enabled false

# Disable welcome tour.
gsettings set org.gnome.shell welcome-dialog-last-shown-version '4294967295'

# Delete this script
rm /home/ubuntu/firstboot.sh
EOF

chown ubuntu:ubuntu /home/ubuntu/firstboot.sh
chmod +x /home/ubuntu/firstboot.sh

cat << EOF > /etc/systemd/user/firstboot.service
[Unit]
Description=One time boot script
After=dbus.service
After=display-manager.service
ConditionPathExists=/home/ubuntu/firstboot.sh

[Service]
Type=oneshot
ExecStart=/home/ubuntu/firstboot.sh

[Install]
WantedBy=default.target
EOF

mkdir -p /home/ubuntu/.config/systemd/user/default.target.wants
ln -s /etc/systemd/user/firstboot.service /home/ubuntu/.config/systemd/user/default.target.wants/firstboot.service

chown -R ubuntu:ubuntu /home/ubuntu/.config

