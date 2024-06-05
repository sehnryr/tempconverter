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
