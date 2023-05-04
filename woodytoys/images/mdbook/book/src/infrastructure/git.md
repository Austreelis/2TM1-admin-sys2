# The git repository

A remote git repository is hosted at [Github][github-remote].

## Branches and history

There are two permanent branches:

- `main`: The main development branch. Quick fixes and uncontroversial changes
  can be pushed on it directly. It is however protected against forced pushes
  and requires a linear history (even when merging pull requests).
- `gh-pages`: The branch used to deploy to github pages. This branch should
  never be pushed to, as this will break the latest wiki deployment on there.
  See [continuous integration](./ci.md) for more informations.

Any change too big or potentially controversial should be pushed to a fork (or
another branch, for maintainers having write access) and a pull request opened.
Once the PR is merged, all the changes will be squashed and rebased on top of
`main` (if there is no conflicts).

## Files &d irectories

### Files in the root

A series of configuration or utility files are placed at the root of the repo:

- `README.md`: A file consicely presenting the project.
- `LICENSE`: The license the files in this repository are distributed under,
  along with the copyright notice.
- `.gitignore`: Git's [ignore file](https://git-scm.com/docs/gitignore).
- `docker-setup.sh`: A script to correctly setup a layer-3 ipvlan docker
  network without having to remember or google the command.
- `flake.nix` (& `flake.lock`): A configuration file declaring a
  [nix](nixos.org) [flake](https://nixos.wiki/wiki/Flakes). See also
  [setting up with nix](../setting-up/nix.md).

### `woodytoys/`

The root directory of the deployment configuration (see
[deployment](../deployment/README.md)). This folder contains:

- `images`: A folder in which each directory contains a `Dockerfile` and the
  files required to build a custom image, e.g. this wiki's image `mdbook`.
- `services`: A folder in which each directory contains configuration file for
  the deployed services, e.g. the php scripts for the `b2b` service.
- `stacks`: A folder containing a series of Docker compose files describing
  groups of services to deploy.
- `docker-compose.yml`: A Docker compose file declaring the services needed to
  run portainer. See also [portainer](../deployment/portainer.md)

[github-remote]: https://github.com/austreelis/2t-admin-sys2

### `wiki/`

The source files for this wiki. See also [this wiki](./wiki.md).

This folder actually is a symbolic link to `woodytoys/images/mdbook/book`,
because the image builds the book and thus needs the source in its context
directory (in the Docker sense).

### `snippet/`

A directory gathering tests, drafts and snippets from early stages in the
project. Likely to get nuked, soon™.

### `.github/`

Github-specific configuration. Notably, we use it to declare jobs to run
automatically on certain events. See also [continuous integration](./ci.md).
