# PostgreSQL backup to OpenStack swift

Docker container that periodically backups a linked PostgreSQL container to
OpenStack swift using [swift](https://github.com/openstack/python-swiftclient)
and cron.

## Base image

This Docker container is built from the official Postgres image.

This allows you to reuse the image you're using (hopefully you're using the
official image), and ensure to use the right version of `pg_dump`.

When you use the `docker run` for this image, you should pass a tag matching
with the version of Postgres you're using.

In case you're using the docker postgres image with the tag `9.1`, you would
have to use the following:

```
$ docker run --rm ... yourcursus/docker-pg_dump-to-swift:9.1
```

Some for version `9.2`, `9.3` and so on.

## Usage

```
$ docker run -d [OPTIONS] yourcursus/docker-pg_dump-to-swift
```

## Parameters:

* `-e OS_TENANT_NAME=<OS_TENANT_NAME>`: Your OpenStack tenant name
* `-e OS_USERNAME=<OS_USERNAME>`: Your OpenStack username
* `-e OS_PASSWORD=<OS_PASSWORD>`: Your OpenStack password
* `-e OS_REGION=<OS_REGION>`: Your OpenStack object storage region
* `-e OS_CONTAINER_NAME=<OS_CONTAINER_NAME>`: The name of the OpenStack storage object container
* `-e PGDATABASE=<PGDATABASE>`: Name of the PostgreSQL database to be backuped

## Optional parameters:

* `-e 'CRON_SCHEDULE=0 1 * * *'`: specifies when cron job starts ([details](http://en.wikipedia.org/wiki/Cron)). Default is `0 1 * * *` (runs every day at 1:00 am).
* `no-cron`: run container once and exit (no cron scheduling).
* `delete`: delete the OpenStack Swift container and exit (no cron scheduling).

## Examples:

Backup the linked PostgreSQL to OpenStack swift everyday at 12:00pm:

```
$ docker run -d \
    -e OS_TENANT_NAME=1122334455667788 \
    -e OS_USERNAME=rHcbN0pNtTyP \
    -e OS_PASSWORD=zfnZzTkxKZ8w6cYYAyKWDgXRzuU7ErTC \
    -e OS_REGION=GRA1 \
    -e PGDATABASE=my_app_production \
    -e 'CRON_SCHEDULE=0 12 * * *' \
    --link your-db-container-name:postgres
    yourcursus/docker-pg_dump-to-swift
```

Run once then delete the container:

```
$ docker run --rm \
    -e OS_TENANT_NAME=1122334455667788 \
    -e OS_USERNAME=rHcbN0pNtTyP \
    -e OS_PASSWORD=zfnZzTkxKZ8w6cYYAyKWDgXRzuU7ErTC \
    -e OS_REGION=GRA1 \
    -e PGDATABASE=my_app_production \
    --link your-db-container-name:postgres
    yourcursus/docker-pg_dump-to-swift no-cron
```

Run once to delete from s3 then delete the container:

```
$ docker run --rm \
    -e OS_TENANT_NAME=1122334455667788 \
    -e OS_USERNAME=rHcbN0pNtTyP \
    -e OS_PASSWORD=zfnZzTkxKZ8w6cYYAyKWDgXRzuU7ErTC \
    -e OS_REGION=GRA1 \
    -e PGDATABASE=my_app_production \
    --link your-db-container-name:postgres
    yourcursus/docker-pg_dump-to-swift delete
```
