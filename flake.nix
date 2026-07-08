{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    self = {
      submodules = true;
    };
  };
  

  outputs = inputs@{ self, nixpkgs, ... }:
    let 
      commonModules = [
        ./common.nix
        inputs.home-manager.nixosModules.default
       ];
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop/configuration.nix 
          ] ++ commonModules;
        };
        
        mac = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/mac/configuration.nix
            inputs.nixos-apple-silicon.nixosModules.default
          ] ++ commonModules;
        };
      };
    };
}
