# Administration Systemes II
*__Groupe 2TM1 - 4__*

## Setting up

### With Nix

> Nix doesn't support Windows. You may get it working under WSL.

> You will need to [install nix](nixos.org/download), which is safe to install
> alongside your usual package manager (if any).

This repository provides a nix flake, allowing easy and reproducible packaging
and configuration.

#### Devshell

This repository provides a development shell, including the appropriate tools
and environment to work on the repository.

To enter the devshell, run:

```
nix develop github:austreelis/2tm1-admin-sys2
```

Or just `nix develop` in a local clone of this repo.
