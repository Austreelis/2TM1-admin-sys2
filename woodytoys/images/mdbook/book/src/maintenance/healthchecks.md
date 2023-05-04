# Service health checks

Most of the service are monitored on a coarse level through
[Docker healthchecks][docker-hc].

## Interpreting health status

Upon starting, a container is in the `starting` state. This means no
healthcheck has been successful yet, but it's still early enough that those
failures do not count toward the maximum amount of failure.

Whenever a healtcheck succeeds, a container becomes `healty`.

If more than a given maximum of healtcheck retries fail, the container becomes
`unhealthy`.

## How to write healthchecks

Healthchecks are scripts or command that exit with code either `0` or `1`
(no other exit code should be used !), and are run in the container's shell.

This means the container's image needs to include all the dependencies needed
to execute the healthcheck, and it must have a shell ! (For instance, the
portainer image we use doesn't).

Alternatively, it may directly execute an executable, but that's often
impractical.

> **Tip:**: an easy way with bash to make any failing command eit with code 1
> instead of any non-zero code is `command that fails || exit 1`.

Ideally, healthchecks should not rely on any other service to be running,
except when service have explicit dependencies (which should be indicated in
the compose file).

Most services use a timeout of 10s, meaning healthchecks running longer than
that will be considered failed even if they succeed later.

[docker-hc]: https://docs.docker.com/engine/reference/builder/#healthcheck
