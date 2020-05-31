# Demo 01

# https://hub.docker.com/r/flyway/flyway
# https://github.com/flyway/flyway-docker

cd ~/Documents/DBA\ Mastery/Migraciones-Flyway;
SQLScripts=~/Documents/DBA\ Mastery/Migraciones-Flyway/Demo_01/SQLScripts;

# Create a test image by running Flyway
docker run --rm flyway/flyway 

# Commands
# --------
# migrate  : Migrates the database
# clean    : Drops all objects in the configured schemas
# info     : Prints the information about applied, current and pending migrations
# validate : Validates the applied migrations against the ones on the classpath
# undo     : [pro] Undoes the most recently applied versioned migration
# baseline : Baselines an existing database at the baselineVersion
# repair   : Repairs the schema history table

# Execute a Flyway instance
docker container run --rm flyway/flyway -url=jdbc:h2:mem:test -user=sa info

# Getting real

docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    flyway/flyway -url=jdbc:h2:mem:test -user=sa migrate