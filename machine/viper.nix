{ config, pkgs, ... }:

{
  # Use the GRUB 2 boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      grub = {
        enable  = true;
        version = 2;
        efiSupport = true;
        device = "nodev";
        efiInstallAsRemovable = true;
      };
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot";
      };
    };
  };

  networking = {
    hostName = "viper";
  };
}
