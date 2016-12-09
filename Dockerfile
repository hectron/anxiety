# Linux image
FROM python:3.5-alpine

# Requirements
RUN apk update && \
    apk add gcc musl-dev postgresql-client libffi-dev ca-certificates
RUN pip install --upgrade pip

# Ensure that if `requirements.txt` changes, we update everything
COPY requirements.txt /tmp/requirements.txt
RUN apk add postgresql-dev && \
    pip install --no-binary :all: -r /tmp/requirements.txt && \
    apk del postgresql-dev

# These are the bootstrap scripts for the rest of the project. They:
#     1. Setup postgres and a postgres database
#     2. Copy the files to set up the application for production or testing.
#     3. Run the application
COPY files/pgpass /var/lib/postgresql/.pgpass
RUN chown postgres:postgres /var/lib/postgresql/.pgpass

COPY files/run_app.sh /etc/run_app.sh

# Move the code
COPY . /app
WORKDIR /app

CMD ["/etc/run_app.sh"]
