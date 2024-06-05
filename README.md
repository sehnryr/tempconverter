# tempconverter

## Publish to GitHub Container Registry

Follow the instructions at https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry
first to authenticate with the GitHub Container Registry.

Then run the following commands to build and push the image to the GitHub Container Registry:

```bash
docker build -t tempconverter:latest .
docker push localhost/tempconverter ghcr.io/sehnryr/tempconverter:latest
```

## Run the project

To run the project, execute the following command:

```bash
docker compose up
```

This will start a mysql container and the tempconverter container. The
tempconverter container will be available at http://localhost:5000.

## Container orchestration

For container orchestration I will use Docker Swarm and Rancher.

Docker Swarm is a container orchestration tool built into Docker. It is easy to
use and is a good starting point for container orchestration. Also, its
syntax is very similar to Docker Compose, which makes it easy to use.

Rancher is a more advanced container orchestration tool that provides a
web-based interface to manage containers. It is more complex than Docker
Swarm, but it provides more features and is easier to use than Kubernetes.

### Using Docker Swarm

> [!NOTE]
> TODO

### Using Rancher

> [!NOTE]
> TODO
