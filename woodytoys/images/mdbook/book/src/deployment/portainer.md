# Portainer

This project uses Portainer to manage anything Docker-related. It doesn't
remove the ability to manage Docker solely from the command line or by editing
the compose files, but rather offers a graphical interface on top of the Docker
Daemon.

## Installing the Portainer server.

On the host, simply run:

```bash
docker-compose --project-directory woodytoys -p portainer up -d
```

Then connect to the host on port `50001`. You should see Portainer's first
launch page, which asks for the creation of an account.

> This documentation will assume the user and its password are `woodytoys` &
> `five-nights-at-freddies`, but you can and should choose better credentials
> 🙂.

Once logged in, you should land on the home page. You should not need to add an
environment for now, so click "get started". Then choose the `local`
environment, that is the Docker daemon Portainer is running on.

You should then be able to see the created stacks: there should only be one,
called "portainer", with "limited" control. This is representing the compose
file declaring the service running for the Portainer server.

Other woodytoys services will be in their own stacks.

If you didn't create layer-3 vlans before, you may now through Portainer's
interface.

## Portainer's container config

> TODO: Explain networks and volumes of the compose file

## Portainer's env and stack setups

> TODO: Explain how we assume stacks and environments are setup
