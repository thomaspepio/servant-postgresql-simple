#!/bin/bash
set -u
#set -e

CONTAINER_NAME=haskell_servant_postgresql_simple

echo "Killing container $CONTAINER_NAME if it exists"
docker kill $CONTAINER_NAME
echo ""

echo "Removing container $CONTAINER_NAME if it exists so that there will be no naming conflicts"
docker rm $CONTAINER_NAME
echo ""

echo "Instantiating new database"
docker run --name $CONTAINER_NAME -p 5432:5432 -d postgres:9.6
sleep 5s
echo ""

echo "Creating an empty haskell_servant_postgresql_simple database"
createdb -h localhost -p 5432 -U postgres haskell_servant_postgresql_simple
echo ""

echo "Creating a haskell_servant_postgresql_simple user"
createuser -h localhost -p 5432 -U postgres -d -l -r -s haskell_servant_postgresql_simple
psql -h localhost -p 5432 -U postgres -c "ALTER USER haskell_servant_postgresql_simple WITH PASSWORD 'haskell_servant_postgresql_simple';"
echo ""

echo "Creating schema etc."
psql -h localhost -p 5432 -U haskell_servant_postgresql_simple -f db/migration.sql
echo ""

echo "You can now connect to postgres with : psql -h localhost -p 5432 -U postgres"
echo "Once logged in, to see what's in the haskell_servant_postgresql_simple database : \c haskell_servant_postgresql_simple "

exit 0
