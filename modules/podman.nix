{ config, lib, ... }:

{
  options.my.podman = {
    enable = lib.mkEnableOption "podman container tooling";
  };

  config = lib.mkIf config.my.podman.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
