# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback acpi_call ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import ./overlays;

  imports =
    [ # Include the results of the hardware scan.
      <musnix>
      ./hardware-configuration.nix
      ./machine/current.nix
    ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb",ATTR{idVendor}=="2982",ATTR{idProduct}=="1967",MODE="0660",GROUP="audio"
  '';

  musnix.enable = true;
  musnix.kernel.optimize = true;
  musnix.kernel.realtime = true;
  musnix.kernel.packages = pkgs.linuxPackages_latest_rt;

  networking.hostName = "viper"; # Define your hostname.
  networking.networkmanager.enable = true;
  #networking.extraHosts =
  #''
  #  45.79.86.75 nextcloud.sidequestboy.com
  #'';
  networking.nameservers = [ "1.1.1.1" ];

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services = {
    upower.enable = true;

    dbus = {
      enable = true;
    };

    blueman.enable = true;

    picom = {
      enable = true;
      fade = true;
      inactiveOpacity = 0.9;
      shadow = true;
      fadeDelta = 4;
    };

    openssh.enable = true;

    xserver = {
      enable = true;

      exportConfiguration = true;

      layout = "us,us";
      xkbModel = "pc104";
      xkbVariant = "dvorak,";
      xkbOptions = "altwin:swap_alt_win,shift:both_capslock";

      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
        touchpad.additionalOptions = ''MatchIsTouchpad "on"'';
      }; 

      #displayManager.defaultSession = "none+xmonad";
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = false;
      desktopManager.gnome3.enable = true;

      #windowManager.xmonad = {
      #  enable = true;
      #  enableContribAndExtras = true;
      #};

    };

    interception-tools = {
      enable = true;
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudio.override { jackaudioSupport = true; };

  hardware.bluetooth.enable = true;

  programs.zsh.enable = true;
  programs.adb.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.jamie = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "tty" "dialout" "audio" "adbusers" "vboxusers" ];
  };

  services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];

  programs.steam.enable = true;

  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #freecad
    ntfs3g
    woeusb
    fritzing
    eudev
    gcc
    gnumake
    nodejs
    pomodoro-new
    zoom-us
    yabridge
    vscode
    droidcam
    obs-studio
    wine-staging
    winetricks
    amdvlk
    vulkan-tools
    steamcmd
    jack2
    qjackctl
    bitwig-studio3
    vlc
    etcher
    transmission-gtk
    gnome3.adwaita-icon-theme
    ripgrep
    alacritty
    arandr
    brightnessctl
    chromium
    discord
    dos2unix
    efibootmgr
    entr
    firefox
    git
    home-manager
    jq
    keepassxc
    libinput
    neovim
    nitrogen
    nix-index
    picocom
    polybar
    python38
    python38Packages.pip
    rofi
    spotify
    tmux
    #todoman
    unzip
    usbutils
    vdirsyncer
    vdirsyncer
    wget vim
    xmobar
    xorg.xev
    zplug
    zsh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

