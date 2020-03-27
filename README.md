https://bit.ly/2WJzWye

What does it do?
Keyboard in BE
Check network
Sync NTP
Lists EFI vars
Prints disklayout
Creates and formats 512MiB EFI part in F32 & rest in btrfs
Makes subvols for / /home /.snapshot /var/log
Include multilib repo
Install Arch base base-devel btrfs-progs 
Create fstab

-- 
ToDo:
Download second .sh to installed env
Run chroot, commanding to run second .sh
This should install some more stuff
Set local vars
Set hostname and hosts
Create swapfile and disable CoW
Setup snapper
Install KDE
Install GRUB
Copy log to /mnt
Reboot to a hopefully working system...
