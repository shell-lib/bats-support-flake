{
  description = "Bats-support helper library";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ...}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in rec {
        bats-support = pkgs.stdenv.mkDerivation {
          name = "bats-support";
          src = pkgs.fetchgit {
            url = "https://github.com/bats-core/bats-support.git";
            rev = "v0.3.0";
            sha256 = "sha256-4N7XJS5XOKxMCXNC7ef9halhRpg79kUqDuRnKcrxoeo=";
          };
          installPhase = ''
            mkdir -p $out/bin
            cp ./load.bash $out/bin/$name.load.bash
            cp -r ./src $out/bin/
          '';
        };
        packages = { default = bats-support; };
      });
}
