{ ... }:
{ ... }:
let

  # Couldn't found this file in nixpkgs bind's derivation outputs, so I simply
  # copy pasted dig's output for a root server query (`dig . ns`).
  rootHintFile = builtins.toFile "root.hints" ''
    . 269327 IN NS f.root-servers.net.
    . 269327 IN NS c.root-servers.net.
    . 269327 IN NS j.root-servers.net.
    . 269327 IN NS i.root-servers.net.
    . 269327 IN NS b.root-servers.net.
    . 269327 IN NS k.root-servers.net.
    . 269327 IN NS a.root-servers.net.
    . 269327 IN NS d.root-servers.net.
    . 269327 IN NS e.root-servers.net.
    . 269327 IN NS h.root-servers.net.
    . 269327 IN NS g.root-servers.net.
    . 269327 IN NS m.root-servers.net.
    . 269327 IN NS l.root-servers.net.

    l.root-servers.net. 274790 IN A    199.7.83.42
    l.root-servers.net. 274903 IN AAAA 2001:500:9f::42
    f.root-servers.net. 275130 IN A    192.5.5.241
    f.root-servers.net. 275139 IN AAAA 2001:500:2f::f
    c.root-servers.net. 274903 IN A    192.33.4.12
    c.root-servers.net. 275862 IN AAAA 2001:500:2::c
    j.root-servers.net. 274790 IN A    192.58.128.30
    j.root-servers.net. 275107 IN AAAA 2001:503:c27::2:30
    i.root-servers.net. 275179 IN A    192.36.148.17
    i.root-servers.net. 276740 IN AAAA 2001:7fe::53
    b.root-servers.net. 274799 IN A    199.9.14.201
    b.root-servers.net. 276696 IN AAAA 2001:500:200::b
    k.root-servers.net. 274823 IN A    193.0.14.129
    k.root-servers.net. 276036 IN AAAA 2001:7fd::1
    a.root-servers.net. 274718 IN A    198.41.0.4
    a.root-servers.net. 274823 IN AAAA 2001:503:ba3e::2:30
    d.root-servers.net. 275554 IN A    199.7.91.13
    d.root-servers.net. 276077 IN AAAA 2001:500:2d::d
    e.root-servers.net. 280727 IN A    192.203.230.10
    e.root-servers.net. 277129 IN AAAA 2001:500:a8::e
    h.root-servers.net. 275017 IN A    198.97.190.53
    h.root-servers.net. 274790 IN AAAA 2001:500:1::53
    g.root-servers.net. 279105 IN A    192.112.36.4
    g.root-servers.net. 317382 IN AAAA 2001:500:12::d0d
    m.root-servers.net. 274780 IN A    202.12.27.33
    m.root-servers.net. 274783 IN AAAA 2001:dc3::35
  '';
in
{
  system.stateVersion = "23.05";

  boot.isContainer = true;

  services.bind = {
    enable = true;
    directory = "/var/cache/bind";
    listenOn = [ "any" ];
    listenOnIpv6 = [ "any" ];
    extraOptions = ''
      allow-transfer { none; };
      allow-recursion {
        localhost;
        localnets;
      };
    '';
    zones = {
      "localhost" = {
        master = true;
        file = "/etc/bind/db.local";
        extraConfig = ''
          allow-update { none; };
          notify no;
        '';
      };
      "127.in-addr.arpa" = {
        master = true;
        file = "/etc/bind/db.127";
        extraConfig = ''
          allow-update { none; };
          notify no;
        '';
      };
    };
    extraConfig = ''
      # services.bind.zones doesn't allow defining "hint" zones
      zone "." IN {
        type hint;
        file "${rootHintFile}";
      };
    
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
  };
}
