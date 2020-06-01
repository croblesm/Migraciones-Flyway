# Demo 02

# https://blog.ghostinthemachines.com/2015/03/01/how-to-use-gpg-command-line/
# https://flywaydb.org/documentation
# https://flywaydb.org/documentation/database/postgresql
# https://flywaydb.org/documentation/database/sqlserver
# https://www.postgresqltutorial.com/psql-commands/
# https://github.com/microsoft/azuredatastudio-postgresql/issues/145
# https://www.postgresqltutorial.com/postgresql-jdbc/connecting-to-postgresql-database/

# SQL Server        : jdbc:sqlserver://<host>:<port>;databaseName=<database>
# PostgreSQL        : jdbc:postgresql://<host>:<port>/<database>?<key1>=<value1>&<key2>=<value2>...

cd ~/Documents/Migraciones-Flyway;
SQLScripts=~/Documents/Migraciones-Flyway/Demo_02/SQLScripts;
ConfigFile=~/Documents/Migraciones-Flyway/Demo_02/ConfigFile;

docker container run \
    --name SQLServer-Demo \
    --hostname SQLServer-Demo \
    --env 'ACCEPT_EULA=Y' \
    --env 'MSSQL_SA_PASSWORD=CmdL1n3-r0ck5' \
    --volume vlm_SQL-Data:/var/opt/mssql \
    --publish 1400:1433 \
    --detach mcr.microsoft.com/mssql/server:2019-CU3-ubuntu-18.04

docker container run \
    --name PostgreSQL-Demo \
    --hostname PostgreSQL-Demo \
    --env 'POSTGRES_PASSWORD=CmdL1n3-r0ck5'\
    --env PGDATA=/var/lib/postgresql/data/pgdata \
    --volume vlm_PG-Data:/var/lib/postgresql/data \
    --publish 5432:5432 \
    --detach postgres:12-alpine

# Connecting to PostgreSQL using Docker
docker exec -it PostgreSQL-Demo psql -U postgres

# Connecting to PostgreSQL using pssql
docker run -it --rm --network host postgres:12-alpine psql -h 172.17.0.2 -U postgres
docker run -it --rm --network host postgres:12-alpine psql "postgresql://postgres:CmdL1n3-r0ck5@172.17.0.2:5432"
docker run -it --rm --network host postgres:12-alpine psql "postgresql://postgres:CmdL1n3-r0ck5@172.17.0.2:5432/worldregions"
docker run -it --rm --network host postgres:12-alpine psql "postgresql://postgres:$PGPASSWORD@172.17.0.2"

# Connecting to SQL Server using sqlcmd
docker run -it --rm --network host mssql-alpine sqlcmd -S localhost,1400 -U sa -P 'CmdL1n3-r0ck5'

docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway info

docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway baseline

docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway info

docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway migrate

#gpg -e -r "carlos" flyway.conf
#gpg -d -q flyway.conf.gpg | flyway info

docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway info

flyway -configFiles=flyway.conf.alt info