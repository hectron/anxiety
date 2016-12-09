# Anxiety

Because sometimes keeping track of everything is relaxing.


### Technologies

- Python 3.5
- Postgres 9.5

## Development

All development can be done using [Docker](https://www.docker.com/) and
[docker-compose](https://docs.docker.com/compose/).

To simply develop, here are the following commands:

    # This downloads the images locally to your machine. A Docker image can be
    # used to create `containers`. The `containers` are the things that run.
    # You may or may not need to do this as a super user.
    docker pull postgres:9.6-alpine
    docker pull python:3.5-alpine

    # This will create a container from the postgres image we retrieved
    sudo docker run --name equitas_db -e POSTGRES_PASSWORD=p0stgres -e POSTGRES_DB=anxiety -d postgres:9.6-alpine

    # Build the container for equitas and then run it, linking up the existing postgres container
    sudo docker build . -t anxiety_webservice
    sudo docker run -i -t --link anxiety_db:postgres anxiety_webservice /bin/sh
