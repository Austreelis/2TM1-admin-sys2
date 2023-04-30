# Networking

> Note: All these steps may be done in Portainer, but you may encounter some
> issues (especially with swarm) reserving the expected address spaces.

## Layer-3 IPVLAN

The containers communicate through a layer-3 ipvlan docker network. However
Portainer cannot create it when creating a stack from a compose file.

The compose files in `woodytoys/stacks` assume a network named
`woodytoys-<stack>-l3ipvlan` is created beforehand, with a series of subnets.

For instance, the `intra` and `client` stacks expect `woodytoys-intra-l3ipvlan`
to be created using this command:

```bash
docker network create \
  -d ipvlan \
  -o parent=<outer-interface> \
  -o ipvlan_mode=l3 \
  --subnet 10.0.0.0/24 \
  --subnet 10.0.1.0/24 \
  --subnet 10.0.2.0/24 \
  --subnet 10.0.3.0/24 \
  --subnet 10.0.4.0/24 \
  --subnet 10.0.5.0/24 \
  --subnet 10.0.6.0/24 \
  --subnet 10.0.7.0/24 \
  woodytoys-intra-l3ipvlan
```

> A script to correctly setup l3-ipvlan networks is available at
> `woodytoys/setup-vlans.sh`.

> Note: if using Docker Swarm, you will need to override the default scope
> (`local`) with `--scope swarm`.
