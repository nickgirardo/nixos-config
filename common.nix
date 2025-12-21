# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [
      # Include home manager is a nixos module (managed by nixos-rebuild)
      inputs.home-manager.nixosModules.home-manager
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.libinput.mouse.naturalScrolling = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Disable automatic power managment on my bluetooth adaptor (it's broken)
  # TODO this is a device specific change
  systemd.services.disable-bt-autosuspend = {
    description = "Disable autosuspend for Intel Bluetooth USB device";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/bash -c 'for dev in /sys/bus/usb/devices/*; do if [[ -f \"$dev/idVendor\" && -f \"$dev/idProduct\" ]]; then if [[ $(cat $dev/idVendor) == \"8087\" && $(cat $dev/idProduct) == \"0032\" ]]; then echo on > $dev/power/control; fi; fi; done'";
    };
  };

  services.logind.settings.Login = {
    # Don't allow programs to prevent suspend on lid close
    LidSwitchIgnoreInhibited = "yes";
  };

  programs.gnome-disks.enable = true;

  # Gnome baloney I don't want to install
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-music
    gnome-characters
    epiphany
    geary
    evince
    totem
  ]);

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8080 ];
  };

  # Configure keymap in X11
  # This isn't used once gnome is completely set up
  # For that check app/gnome_dconf.nix
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "terminate:ctrl_alt_bksp,caps:ctrl_modifier";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable bluetooth support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Services for usb devices
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Define a user account
  users.users.nick = {
    isNormalUser = true;
    description = "Nick";
    extraGroups = [ "networkmanager" "wheel" "dialout" "storage" "render" ];
    hashedPassword = "$y$j9T$GHYOqfKwIO6pQ3YE9ystK.$KRk/16.oJ5St/ZG8omYseq5k2zgkUo4EqVwjxdW4c02";
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.nick = import ./home.nix;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git-lfs

    tree

    # man pages
    man-pages
    man-pages-posix
  ];

  environment.wordlist.enable = true;

  documentation.dev.enable = true;

  programs.bash.promptInit = ''PS1="\\$ "'';

  # For some reason you can't install steam through HomeManager
  programs.steam = {
    enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # services.flatpak.enable = true;
  # systemd.services.flatpak-repo = {
    # description = "Add flatpak remotes";
    # wantedBy = [ "multi-user.target" ];
    # path = [ pkgs.flatpak ];
    # script = ''
      # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      # flatpak remote-add --if-not-exists JagexLauncher https://jagexlauncher.flatpak.mcswain.dev/JagexLauncher.flatpakrepo
    # '';
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
