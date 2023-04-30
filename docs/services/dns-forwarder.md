# DNS Forwarder

## Description

Forwards DNS requests from the trusted zoned to the relevant DNS server of the
infrastructure. It allows splitting our [resolver][srv:resolver],
[private][srv:soa-private] and [public SOAs][srv:soa-public] into
different services.

## Usage

Hosts and services in the [trusted zone][ntw:trusted-zone] are expected to set
this server as their dns server.

## Interactions & Dependency

The service technically depends on any among the resolver and SOAs to be up,
but `docker compose` doesn't allow expressing this kind of condition without
fragile workarounds. So in practice, this service has no dependency.

```
                [Client]
                  ^ |
receives response | | sends DNS requests to
                  | v
           [DNS Forwarder]
                  ^ |
receives response | | forwards request to, if...
                  | |
                  | +----.
                  +-|--. |
                  | |  | | it is in the domain `intra.woodytoys.be`
                  | |  | v
                  | | [Private SOA]
TRUSTED-ZONE      | |
-------------------------------------------------------------------------------
DMZ               | |
                  | +----.
                  +-|--. |
                  | |  | | it is in the zone `woodytoys.be`
                  | |  | v
                  | | [Public SOA]
                  | |
                  | | otherwise
                  | v
                 [Resolver]
```

## Configuration

### Docker rules

- `hostname`: `ns0`

  This allows the name resolution for the host to follow straightforward scheme
  `<hostname>.<domain>` and coincide with one of the advised name server's name
  `ns0.<zone>` (`ns0.intra.woodytoys.be` in this case).

### Volumes

No volumes are used.

### Monitoring

No statistics are exported.

[srv:resolver]: ../../services/dns/resolver.md
[srv:soa-private]: ../../services/dns/soa-private.md
[srv:soa-public]: ../../services/dns/soa-public.md
[ntw:trusted-zone]: ../../networks/trusted-zone.md
