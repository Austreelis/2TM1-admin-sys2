{
  inputs = {
    nixpkgs.url = "nixpkgs";
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "deploy-rs/utils";
    };
  };

  outputs = inputs:
    let
      inherit (inputs) deploy-rs devshell nixpkgs self;
      inherit (nixpkgs.lib) foldl' lists mapAttrs recursiveUpdate;

      # List of attrs merging helper functions
      merge = foldl' recursiveUpdate { };

      mergeMap = f: xs: merge (lists.map f xs);

      # Supported host systems
      systems = [
        "x86_64-linux"
      ];

      allFiles = lists.map import [
        ./snippets/resolver
        ./snippets/client
      ];

      mkOutputs = system:
        let
          # Package set
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              deploy-rs.overlays.default or deploy-rs.overlay
              devshell.overlays.default or devshell.overlay
            ];
          };

          # Default development shell
          shells.default = {
            devshell.name = "2tm1-admin-sys2";

            commands = [
              { package = pkgs.nixpkgs-fmt; category = "nix"; }

              { package = pkgs.podman; category = "containers"; }
              { package = pkgs.docker; category = "containers"; }
              { package = pkgs.docker-compose; category = "containers"; }

              {
                name = "deploy";
                package = pkgs.deploy-rs.deploy-rs;
                category = "deployment";
              }
            ];

            devshell.packages = [
              pkgs.nil
              pkgs.nodePackages.dockerfile-language-server-nodejs
            ];
          };
        in
        (
          mergeMap
            (f: f {
              inherit pkgs system deploy-rs devshell nixpkgs self;
              inherit (nixpkgs) lib;
            })
            (allFiles ++ [
              (_: {
                # Development shell
                devShells.${system} =
                  mapAttrs
                    (_: pkgs.devshell.mkShell)
                    shells;

                # Deploy-rs settings
                # https://github.com/serokell/deploy-rs#generic-options
                deploy = {
                  sshUser = "deploy";
                  sshOpts = [ "-p" "3022" ];
                  tempPath = "/run/deploy";
                  # We may enable remote builds when a properly configured
                  #remoteBuild = true;
                };

                # Check of deployment configs
                checks =
                  mapAttrs
                    (_: deployLib: deployLib.deployChecks self.deploy)
                    deploy-rs.lib;
              })
            ])
        );
    in
    mergeMap mkOutputs systems;
}
