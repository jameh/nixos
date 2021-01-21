# NixOS on viper

```
wpa_supplicant -B -i wlp1s0 -c <(wpa_passphrase 'SSID' 'key')
```

- partition hard drives with `fdisk /dev/sda`:
  - sda[1,3,4] for windows 10
  - sda2 ESP
  - sda5 nixos
  - sda6 swap

- format partitions:
  - `mkfs.ext4 -L nixos /dev/sda5`
  - `mkswap -L swap /dev/sda6`

- turn on swap: `swapon`

- mount partitions for install

```
nixos install
```
