{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    rust-flake = {
      url = "github:juspay/rust-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    process-compose-flake = {
      url = "github:Platonic-Systems/process-compose-flake/f6ce9481df9aec739e4e06b67492401a5bb4f0b1";
    };
    cargo-doc-live = {
      url = "github:srid/cargo-doc-live/b09d5d258d2498829e03014931fc19aed499b86f";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      flake = false;
      # inputs.nixpkgs.follows = "nixpkgs"; #non-existant input
    };

    # Dev tools
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # personal repos
    dotfiles = {
      url = "github:gignsky/dotfiles";
      flake = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      # See ./nix/modules/*.nix for the modules that are imported here.
      imports = with builtins;
        map
          (fn: ./nix/modules/${fn})
          (attrNames (readDir ./nix/modules));

    };
}
