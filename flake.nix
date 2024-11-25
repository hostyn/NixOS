{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; # Nix Packages (Default)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages
    nix-colors.url = "github:misterio77/nix-colors"; # Nix Colors
    grub2-themes.url = "github:vinceliuice/grub2-themes"; # Grub themes

    # Sops Nix
    sops-nix.url = "github:Mic92/sops-nix?rev=c5ae1e214ff935f2d3593187a131becb289ea639"; # Pin commit because of a bug introduced in #654?? Check #659
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # VSCode Extensions
    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs @ {...}: {
    nixosConfigurations = (
      import ./hosts {
        inherit inputs;
      }
    );
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
