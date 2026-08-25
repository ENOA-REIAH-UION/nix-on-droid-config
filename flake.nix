{
  description = "Basic example of Nix-on-Droid system config.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/prerelease-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nu_scripts = {
      url = "github:nushell/nu_scripts";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nix-on-droid, ... }@allInputs: let
    inputs = allInputs // { nu_scripts = self.inputs.nu_scripts; };
    pkgs-unstable = import inputs.nixpkgs-unstable {
      system = "aarch64-linux";
      config = { allowUnfree = true; };
    };
  in {

    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import nixpkgs {
        system = "aarch64-linux";
        config = {
          android_sdk.accept_license = true;
          allowUnfree = true;
        };
      };
      

      modules = [
        ./nix-on-droid.nix
        ({ lib, pkgs, ... }: {
          _module.args.nu_scripts = inputs.nu_scripts;
          _module.args.pkgs-unstable = pkgs-unstable;
        })
      ];
    };

  };
}
