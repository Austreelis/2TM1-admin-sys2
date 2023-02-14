{ ... }:
{ pkgs, ... }:
{
  system.stateVersion = "23.05";

  boot.isContainer = true;

  services.getty.autologinUser = "root";

  environment.systemPackages = [
    pkgs.bind
  ];
}
