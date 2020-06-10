# Demo 01 - Flyway Introduction
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

cd ~/Documents/Migraciones-Flyway/Demo_01;
SQLScripts=~/Documents/Migraciones-Flyway/Demo_01/SQLScripts;
ConfigFile=~/Documents/Migraciones-Flyway/Demo_01/ConfigFile;

# 1- Downloading Flyway command-line tool
# macOS 
# brew install flyway

# Local command-line tool
flyway

# Docker container
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

# Flyway info
# Docker container
docker container run --rm flyway/flyway -url=jdbc:h2:mem:FlyWay-Test -user=sa info

# Local command-line tool
flyway info -url=jdbc:h2:mem:FlyWay-Test -user=sa -password=s3cr3t

# Flyway migration
Demo_01
├── ConfigFile
│   └── flyway.conf
└── SQLScripts
    └── V1__FlywayIntroduction.sql

# Dummy SQL script
code $SQLScripts/V1__FlywayIntroduction.sql

# flyway.locations must be modifed with local command-line
code $ConfigFile/flyway.conf

# Database migration (dummy)
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    flyway/flyway -url=jdbc:h2:mem:FlyWay-Test -user=sa migrate

# Flyway Configuration file
# Creating a conf file
code $ConfigFile/flyway.conf

# Testing configuration file
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway migrate