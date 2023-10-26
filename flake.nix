{
  inputs = {
    opam-nix.url = "github:tweag/opam-nix";
    flake-utils.url = "github:numtide/flake-utils";
    opam-nix.inputs.nixpkgs.follows = "nixpkgs";
    # maintain a different opam-repository to those pinned upstream
    opam-repository = {
      url = "github:ocaml/opam-repository";
      flake = false;
    };
    opam-nix.inputs.opam-repository.follows = "opam-repository";
  };
  outputs = { self, flake-utils, opam-nix, nixpkgs, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        package = "wol";
        pkgs = nixpkgs.legacyPackages.${system};
        on = opam-nix.lib.${system};
        devPackagesQuery = {
          ocaml-lsp-server = "*";
          ocamlformat = "*";
          # 1.9.6 fails to build
          ocamlfind = "1.9.5";
          utop = "*";
        };
        query = { ocaml-base-compiler = "*"; };
        scope = on.buildOpamProject' { } ./. (query // devPackagesQuery);
      in rec {
        packages = scope;
        defaultPackage = packages.${package};
      }
    );
}
