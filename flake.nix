{
  description = "My NixOS Configuration :-)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nur.url = "github:nix-community/NUR/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
  in {
    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix ];
    };
  };
}
