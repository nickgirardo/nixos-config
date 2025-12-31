# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Set hostname
  networking.hostName = "bellshrimp";

  # Disable automatic power managment on my bluetooth adaptor (it's broken)
  systemd.services.disable-bt-autosuspend = {
    description = "Disable autosuspend for Intel Bluetooth USB device";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/bash -c 'for dev in /sys/bus/usb/devices/*; do if [[ -f \"$dev/idVendor\" && -f \"$dev/idProduct\" ]]; then if [[ $(cat $dev/idVendor) == \"8087\" && $(cat $dev/idProduct) == \"0032\" ]]; then echo on > $dev/power/control; fi; fi; done'";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
