{ ... }:
{ ... }:
{
  system.stateVersion = "23.05";

  boot.isContainer = true;

  services.bind = {
    enable = true;
    directory = "/var/cache/bind";
    extraOptions = ''
      allow-transfer { none; };
    '';
    extraConfig = ''
      logging {
        channel "misc" {
          file "/var/log/named/misc.log" versions 4 size 4m;
          print-time YES;
          print-severity YES;
          print-category YES;
        };
        channel "query" {
          file "/var/log/named/query.log" versions 4 size 4m;
          print-time YES;
          print-severity NO;
          print-category NO;
        };
        category default { "misc"; };
        category queries { "query"; };
      }
    '';
    zones = {
      "2tm1-admin-sys2.ephec.austreelis.net" = {
        master = true;
        file = ./2tm1-admin-sys2.ephec.austreelis.net.zone;
      };
    };
  };
}
