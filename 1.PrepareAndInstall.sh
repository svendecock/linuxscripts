#!/bin/sh
## Booting
--
## Preparing Installation
# Loadkeys
loadkeys be-latin1
# Verify network connectivity
ifconfig
ping -c2 google.com
--
# Sync NTP
timedatectl set-ntp true
--
# Print UEFI mode
ls /sys/firmware/efi/efivars
--
# Print partition layout
lsblk
fdisk -l
--
# Creating partitions
parted /dev/nvme0n1 mklabel gpt \
                    mkpart primary fat32 1MiB 512MiB \
                    set 1 esp on \
                    mkpart primary btrfs 512MiB 100%
mkfs.fat -F32 /dev/nvme0n1p1                    
mkfs.btrfs -L "Arch Linux" /dev/nvme0n1p2
mount /dev/nvme0n1p1 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@log
btrfs subvolume list /mnt
umount /mnt
mount -o ssd,compress=lzo,noatime,subvol=@ /dev/nvme0n1 /mnt
mkdir -p /mnt/{var/log,home,.snapshots}
mount -o ssd,compress=lzo,noatime,subvol=@home /dev/nvme0n1 /mnt/home
mount -o ssd,compress=lzo,noatime,subvol=@logs /dev/nvme0n1 /mnt/var/log
mount -o ssd,compress=lzo,noatime,subvol=@snapshots /dev/nvme0n1 /mnt/snapshots
--
# Add multilib to pacman
echo "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
--
## Installation
pacstrap -i /mnt base base-devel btrfs-progs
--
# Generate fstab file, with UUID's
genfstab -U -p /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
--
