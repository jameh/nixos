{ config, lib, pkgs, ... }:

{
  services = {
    upower.enable = true;

    dbus = {
      enable = true;
    };
    xserver = {
      enable = true;
      layout = "dvorak";

      libinput = {
        enable = true;
      };
      displayManager.defaultSession = "none+xmonad";

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      xkbOptions = "caps:ctl_modifier";

    };
  };

  systemd.services.upower.enable = true;

}

