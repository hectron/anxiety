#!/bin/bash

# Why is this script necessary, <insert_author_name>? Doesn't Docker compose
# take care of spinning up services in the right order?

# Great question, <insert_engineer_name_here>! Technically, it is true -- docker
# compose DOES spin up the containers under the services.  However, in our case,
# postgres (or `db`) is spun up first.

# Once the DOCKER container has been spun, it sends a signal to the main service
# saying that it is now ready to be awesome.  What is not known is that though
# the `db` docker image is ready, the dependencies inside of it (namely
# Postgres) are NOT ready yet. Remember, when the docker image starts, it still
# needs to install software.

# Therefore, this script brings up the db first, waits for Postgres to be
# installed and ready to take connections, then it starts up the rest of the
# services.  There might be a better way, but this just checks the logs to see
# if the line `PostgreSQL init process complete` has been inserted, then it
# carries on with whatever is necessary.

# set colors for use on stdout / sdterr
GREEN='\e[32m'
BLUE='\e[34m'
YELLOW='\e[0;33m'
RED='\e[31m'
BOLD='\e[1m'
CLEAR='\e[0m'

# colorize ok, warning, and error indicators
OK="[${GREEN}OK${CLEAR}]"
INFO="[${BLUE}INFO${CLEAR}]"
NOTICE="[${YELLOW}!!${CLEAR}]"
ERROR="[${RED}ERROR${CLEAR}]"

# Compose namespace
compose_namespace=${1:-default}

# Bring up postgres

echo -e "$OK Ensuring everything is down."
docker-compose -p $compose_namespace down

echo -e "$OK Everything is down. Building the app image"
docker-compose -p $compose_namespace build web

echo -e "$OK Bringing up the database. We'll wait for it to be ready. It's going to be -- wait for it --"
docker-compose -p $compose_namespace up -d db

sleep 3

while true
do
  docker-compose -p $compose_namespace logs db 2>&1 | grep -i "PostgreSQL init process complete" \
    && break
  echo -e "$INFO Keep waiting...."
  sleep 1
done

echo -e "$OK LEGENDARY. Time to be awesome.."
docker-compose -p $compose_namespace up
