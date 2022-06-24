{
  description = "IPython shell including libraries I commonly use";

  inputs.nixos.url = "github:dpaetzel/nixos-config";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixos, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let nixpkgs = import nixos.inputs.nixpkgs { inherit system; };
      in {

        defaultPackage = nixpkgs.python310.withPackages
          (pkgs: with pkgs; [ ipython matplotlib numpy pandas scipy ]);

        # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-run.html
        # TODO Use meta.mainProgram attribute (seems to be becoming the standard?)
        apps.default = {
          type = "app";
          program = "${self.defaultPackage.${system}}/bin/ipython";
        };

      });
}
