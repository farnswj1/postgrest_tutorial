# PostgREST Tutorial
This is a containerized PostgREST tutorial.

## Setup
The project uses the following:
- PostgreSQL
- PostgREST
- Nginx
- Certbot
- Docker
- Docker Compose

### PostgreSQL
The ```postgres``` directory must also have a ```.env``` file with the following configurations. It is highly recommended to use your own credentials instead of the values provided:
```
POSTGRES_DB=example
POSTGRES_USER=postgres
POSTGRES_PASSWORD=password
```

### PostgREST
In the ```postgrest``` directory, create a ```.env``` file that contains the following configurations:
```
PGRST_DB_URI=postgres://authenticator:mysecretpassword@postgres:5432/postgres
PGRST_DB_SCHEMAS=api
PGRST_DB_ANON_ROLE=web_anon
PGRST_JWT_SECRET=asecretkeywithaminlengthofthirtytwo
```

The database variables can be changed as desired. However, make sure to update the  PostgreSQL environment variables as well.

## Running
The project uses Docker. Ensure Docker and Docker Compose are installed before continuing.

To run the web app, run ```docker compose up -d```, then go to http://localhost using your web browser.

## Setting Up the Database
Some initial setup is required. To set up the database, copy `postgres/setup.sql` into the `postgres` container via `docker cp ./postgres/setup.sql postgres:/`, then run ```docker exec postgres psql -U postgres -f /setup.sql```. You may also need to restart PostgREST to ensure it connects afterwards.

### Setting Up HTTPS With Certbot
There are configurations already set up via `cli.ini` in the `certbot` directory. To receive an SSL certificate using those configurations, run:
```
docker compose run --no-deps --rm certbot certonly -d [enter domain here]
```

Fill out the prompt, then configure Nginx to use the SSL certificate and domain.

To renew the SSL certificate and use the newest certificate, run:
```
docker compose run --no-deps --rm certbot renew && docker exec nginx nginx -s reload
```

**NOTE**: Ensure port 443 is exposed in `docker-compose.yml` for HTTPS.
