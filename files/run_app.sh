#!/bin/sh

################################################################################
# To run in Docker, the image needs to be built and the container must be run.
# docker build -t equitas_webapp .
# docker run --net=host equitas_webapp
################################################################################
set -xv
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

sed -i 's,'"{{ POSTGRES_USER }}"','$POSTGRES_USER',' /var/lib/postgresql/.pgpass
sed -i 's,'"{{ POSTGRES_PASSWORD }}"','$POSTGRES_PASSWORD',' /var/lib/postgresql/.pgpass

PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -h $POSTGRES_HOST -d $POSTGRES_DB -f database/schema.sql

echo -e "$OK Running application!"
python runserver.py
