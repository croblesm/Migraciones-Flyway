# Demo 02 - PostgreSQL Migration - New database
# 
#   1- Downloading Flyway command-line tool
#   2- Getting familiar with Flyway (Docker | App)
#       Flyway info
#       Flyway migrate   
# -----------------------------------------------------------------------------
# Reference:
#   https://hub.docker.com/r/flyway/flyway
#   https://github.com/flyway/flyway-docker
#   https://flywaydb.org/download/#downloads

# https://blog.ghostinthemachines.com/2015/03/01/how-to-use-gpg-command-line/
# https://flywaydb.org/documentation
# https://flywaydb.org/documentation/database/postgresql
# https://flywaydb.org/documentation/database/sqlserver
# https://www.postgresqltutorial.com/psql-commands/
# https://github.com/microsoft/azuredatastudio-postgresql/issues/145
# https://www.postgresqltutorial.com/postgresql-jdbc/connecting-to-postgresql-database/

# SQL Server        : jdbc:sqlserver://<host>:<port>;databaseName=<database>
# PostgreSQL        : jdbc:postgresql://<host>:<port>/<database>?<key1>=<value1>&<key2>=<value2>...

# Cleanup
# dkrm PostgreSQL-Demo;
# docker volume rm vlm_PG-Data;
# mv ./SQLScripts/V2__LoadData.sql ./SQLScripts/--V2__LoadData.sql;

# 0- Env variables | demo path
cd ~/Documents/Migraciones-Flyway/Demo_02;
SQLScripts=~/Documents/Migraciones-Flyway/Demo_02/SQLScripts;
ConfigFile=~/Documents/Migraciones-Flyway/Demo_02/ConfigFile;

# 1- Create PostgreSQL container with worldregions database
docker container run \
    --name PostgreSQL-Demo \
    --hostname PostgreSQL-Demo \
    --env POSTGRES_DB=worldregions \
    --env 'POSTGRES_PASSWORD=CmdL1n3-r0ck5' \
    --volume vlm_PG-Data:/var/lib/postgresql/data \
    --publish 5432:5432 \
    --detach postgres:12-alpine

# 2- Connect to PostgreSQL using psql (within Docker)
docker exec -it PostgreSQL-Demo psql -U postgres -d worldregions

# 3- Execute basic PostgreSQL commands

# List all databases
# psql command: \list | \l
SELECT datname FROM pg_database;

# List all tables in worldregions     
# psql command: \dtables | \dt
SELECT table_name FROM information_schema.tables where table_schema ='public';

# Exit psql session
# psql command: \quit | \q
quit;

# 4- Flyway migration files and structure
Demo_02
├── ConfigFile
│   └── flyway.conf
└── SQLScripts
    ├── V1__CreateStructures.sql
    └── --V2__LoadData.sql

# Explore Confile
code ./ConfigFile/flyway.conf

# Explore SQL Scripts
code ./SQLScripts/V1__CreateStructures.sql;

# 5- Flyway migration files and structure
# Initializing
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway info

# Perform V1 migration
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway migrate

# Check status
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway info

# Add more scripts
code ./SQLScripts/--V2__LoadData.sql;
mv ./SQLScripts/--V2__LoadData.sql ./SQLScripts/V2__LoadData.sql;

# New folder structure
Demo_02
├── ConfigFile
│   └── flyway.conf
└── SQLScripts
    ├── V1__CreateStructures.sql
    └── V2__LoadData.sql

# Check status
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway info

# Perform V1 migration
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway migrate

# Azure Data Studio

docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway clean