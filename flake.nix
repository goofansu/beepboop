{
  description = "Exporing Phoenix LiveView";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, devenv, ... }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.devenv-up =
        self.devShells.${system}.default.config.procfileScript;

      devShells.${system}.default = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          ({ pkgs, ... }: {
            packages = [ pkgs.beam.packages.erlang_27.elixir_1_17 ];
            services = {
              postgres = {
                enable = true;
                initialDatabases = [{ name = "beepboop"; }];
                initialScript = ''
                  CREATE ROLE postgres SUPERUSER LOGIN;
                '';
              };
            };
          })
        ];
      };
    };
}
