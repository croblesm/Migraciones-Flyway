# Demo 01

# https://hub.docker.com/r/flyway/flyway
# https://github.com/flyway/flyway-docker

cd ~/Documents/Migraciones-Flyway;
SQLScripts=~/Documents/Migraciones-Flyway/Demo_01/SQLScripts;
ConfigFile=~/Documents/Migraciones-Flyway/Demo_01/ConfigFile;

# Create a test image by running Flyway
docker container run --rm flyway/flyway 

# Commands
# --------
# migrate  : Migrates the database
# clean    : Drops all objects in the configured schemas
# info     : Prints the information about applied, current and pending migrations
# validate : Validates the applied migrations against the ones on the classpath
# undo     : [pro] Undoes the most recently applied versioned migration
# baseline : Baselines an existing database at the baselineVersion
# repair   : Repairs the schema history table

# Getting migration info
docker container run --rm flyway/flyway -url=jdbc:h2:mem:FlyWay-Test -user=sa info

# Getting started with an empty migration
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    flyway/flyway -url=jdbc:h2:mem:FlyWay-Test -user=sa migrate

# Creating a conf file
code $ConfigFile/flyway.conf

# Getting started with an empty migration
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway migrate