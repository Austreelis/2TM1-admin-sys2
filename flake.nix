{
  inputs = {
    nixpkgs.url = "nixpkgs";
    devshell.url = "github:numtide/devshell";
  };

  outputs = inputs: let
    inherit (inputs) devshell nixpkgs;
    inherit (nixpkgs.lib) foldl' lists mapAttrs recursiveUpdate;

    # Supported host systems
    systems = [
      "x86_64-linux"
    ];

    mkOutputs = system: let
      # Package set
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ devshell.overlays.default or devshell.overlay ];
      };

      # Default development shell
      shells.default = {
        devshell.name = "2tm1-admin-sys2";

        commands = [
          { package = pkgs.podman; category = "containers"; }
          { package = pkgs.docker; category = "containers"; }
        ];

        devshell.packages = [
          pkgs.nodePackages.dockerfile-language-server-nodejs
        ];
      };
    in {
      devShells.${system} = mapAttrs (_: pkgs.devshell.mkShell) shells;
    };
  in foldl' recursiveUpdate { } (lists.map mkOutputs systems);
}
