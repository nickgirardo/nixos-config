{
  description = "My NixOS Configuration :-)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nur.url = "github:nix-community/NUR/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
  in {
    nixosConfigurations = {
      frameworkLaptop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./common.nix
          ./hosts/framework-laptop/default.nix
        ];
      };

      thinkpad = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./common.nix
          ./hosts/thinkpad/default.nix
        ];
      };

      frameworkDesktop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./common.nix
          ./hosts/framework-desktop/default.nix
        ];
      };

    };
  };
}
