{ lib, deploy-rs, nixpkgs, self, ... } @ args:
let
  inherit (lib) nixosSystem;
in
{
  nixosConfigurations.simple-client = nixosSystem {
    system = "x86_64-linux";
    modules = [ (import ./configuration.nix args) ];
  };
 
  deploy.nodes.simple-client = {
    hostname = "eadu.local.abeess.austreelis.net";

    # Deploy 'system' first
    profilesOrder = [ "system" ];

    profiles.system = {
      user = "root";
      path =
        deploy-rs.lib.x86_64-linux.activate.nixos
          self.nixosConfigurations.simple-client;
    };
  };
}
