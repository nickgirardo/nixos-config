{
  description = "My NixOS Configuration :-)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nur.url = "github:nix-community/NUR/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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
      modules = [ ./configuration.nix ];
    };
    homeConfigurations.nick = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
      extraSpecialArgs = { inherit inputs; };
    };
  };
}
