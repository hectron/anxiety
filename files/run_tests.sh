#!/bin/sh

sed -i 's,'"{{ POSTGRES_USER }}"','$POSTGRES_USER',' /var/lib/postgresql/.pgpass
sed -i 's,'"{{ POSTGRES_PASSWORD }}"','$POSTGRES_PASSWORD',' /var/lib/postgresql/.pgpass

echo "Setting up test database..."
psql -d $POSTGRES_DB -U $POSTGRES_USER -a -f equitas/schema.sql


# Run the tests!
# TODO revisit this
coverage run --source equitas /usr/local/bin/trial tests
