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

To use Docker Swarm, first initialize the swarm:

```bash
docker swarm init
```

Then deploy the stack:

```bash
docker stack deploy -c docker-stack.yml tempconverter
```

To scale the tempconverter app, run the following command:

```bash
docker service scale tempconverter_app=3
```

#### Troubleshooting

If you get the following error:

```
Error response from daemon: --live-restore daemon configuration is incompatible with swarm mode
```

You need to disable live restore in the Docker daemon. To do this, edit the
`/etc/docker/daemon.json` file and add the following line:

```json
{
    "live-restore": false
}
```

Then restart the Docker daemon:

```bash
sudo systemctl restart docker
```

Then try to deploy the stack again.

If the error persists, you may need to create an override file for the Docker
service. To do this, add the following to
`/etc/systemd/system/docker.service.d/override.conf`
([source](https://github.com/moby/moby/issues/25471#issuecomment-263101090)):

```conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd
```

Then reload the systemd configuration:

```bash
sudo systemctl daemon-reload
```

And restart the Docker daemon:

```bash
sudo systemctl restart docker
```

Then try to deploy the stack again.

### Using Rancher

To use Rancher, first install Rancher on your server:

```bash
sudo docker run -d --restart=unless-stopped \
    -p 80:80 -p 443:443 \
    --privileged \
    rancher/rancher:v2.8.4
```

Then access the Rancher web interface at http://localhost. Follow the
instructions to set up Rancher and its cli tool.

Then deploy the app and the database:

```bash
rancher kubectl apply -f persistentvolume-db.yml
rancher kubectl apply -f persistentvolumeclaim-db.yml
rancher kubectl apply -f deployment-db.yml
rancher kubectl apply -f service-db.yml
rancher kubectl apply -f deployment-app.yml
rancher kubectl apply -f service-app.yml
```

To scale the app, run the following command:

```bash
rancher kubectl scale deployment/tempconverter-app --replicas=3 --namespace=local
```
