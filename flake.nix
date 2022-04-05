{
  description = "IPython shell including libraries I commonly use";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      with import nixpkgs { inherit system; }; {

        defaultPackage = nixpkgs.legacyPackages.${system}.python39.withPackages
          (pkgs: with pkgs; [ ipython matplotlib numpy pandas scipy ]);

        defaultApp = flake-utils.lib.mkApp {
          drv = self.defaultPackage.${system};
          exePath = "/bin/ipython";
        };

      });
}
