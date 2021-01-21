# NIXOS on blueberry

Download and flash to usb Minimal ISO Image:

https://nixos.org/download.html

```
dd if=nixos-minimal.iso of=/dev/path/to/usb bs=1M status=progress oflag=sync
```

- keyboard and root

```
sudo loadkeys dvorak
sudo su
```

- connect to wifi

```
wpa_supplicant -B -i wlp1s0 -c <(wpa_passphrase 'SSID' 'key')
```

- set nixos passwd for ssh

```
passwd nixos
```

- optionally ssh from remote machine 

- partition hard drives with `fdisk /dev/mmcblk0`:
  - 512M EFI System
  - 24.6G Linux filesystem
  - 4G Linux swap

- format partitions:
  - `mkfs.fat -F 32 -n boot /dev/mmcblk0p1`
  - `mkfs.ext4 -L nixos /dev/mmcblk0p2`
  - `mkswap -L swap /dev/mmcblk0p3`

- turn on swap: `swapon`

- mount partitions for install

```
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
```

- generate config

```
nixos-generate-config --root /mnt
vim /mnt/etc/nixos/configuration.nix
```

- install git temporarily

```
nix-env -f '<nixpkgs>' -iA git
```

```
nixos install
```





