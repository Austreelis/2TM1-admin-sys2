# Docker Swarm

Although it wasn't extensively tested, deploying with Docker Swarm should be
straightforward.

### Why use Swarm ?

The benefits of deploying using Docker Swarm mainly are the following:

#### Using the Portainer Agent

A Portainer Agent installed on the host allows managing several hosts from a
single Portainer server. Even without Swarm, it would be the easiest solution
to manage two separate hosts running Woodytoys' containers (instead of having
two different Portainer servers).

The "default" setup outlined in this documentation runs a Portainer server
on the host, alongside all other containers. It directly talks to the host's
Docker daemon. While it's possible to use the Portainer Agent with this setup
already, we did not set this up. However, it's considered bad practice not to
when using Swarm (and practically a lot harder to manage).

So while the Portainer Agent could come useful without Swarm, it's not really
worth the work to setup just yet, but could bring more value than just enabling
Swarm.

#### Better scalability

Swarm allows to easily replicate services and run them accross several
hosts (nodes, in Swarm jargon). While this needs some more work than what's
currently setup, it should only require some adjustment to the routing and
DNS infrastructure.

### Deploying with Docker Swarm

To deploy Woodytoys' stack with Swarm, you should first choose a host, or node,
that will act as a "manager" for the swarm. All nodes may be manager, but you
may want some nodes to only be able to run services without managing others.

> For instance, with enough nodes, it's common to have some dedicated to
> "public-facing" services so that comprimising one of them doesn't necessarily
> gives managing rights on the Swarm.

On the "initial" manager node, create a new swarm. You may want to look at the
options first:

```bash
docker swarm init --help
# Then actually create one, adding options you see fit
docker swarm init --advertise-addr ens33 --listen-addr ens33
```

Then run the portainer agent:

```bash
docker run -d \
  -p 9001:9001 \
  --restart always \
  --name portainer_agent \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  portainer/agent:latest
```

Before continuing to setup Portainer in the next section. You may run the
server on this host, or any other, as long as it can reach its port `9001`.

See also [Portainer's][install-agent] and [Docker's][docker-swarm]
documentation.

### Adding a node to the Swarm

To add a node, you will need to generate a "worker" or "manager" token
(depending on which kind of node you want to add), from any existing manager
node:

```bash
docker swarm join-token worker
# Or manager instead of worker
```

Copy or transfer the token somehow, then on the new node:

```bash
docker swarm join --token <the-token-from-previous-step> <manager-ip>:<port>
```

Finally, run the portainer agent:

```bash
docker run -d \
  -p 9001:9001 \
  --restart always \
  --name portainer_agent \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  portainer/agent:latest
```

You should be able to deploy services to this node from your Portainer server.

See also [Portainer's][install-agent] and [Docker's][docker-swarm]
documentation.

[install-agent]: https://docs.portainer.io/admin/environments/add/docker/agent
[docker-swarm]: https://docs.docker.com/engine/swarm/
