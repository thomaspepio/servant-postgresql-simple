#!/bin/bash
set -u
#set -e

CONTAINER_NAME=haskell_clean_archi_for_free

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

echo "Creating an empty haskell_clean_archi_for_free database"
createdb -h localhost -p 5432 -U postgres haskell_clean_archi_for_free
echo ""

echo "Creating a haskell_clean_archi_for_free user"
createuser -h localhost -p 5432 -U postgres -d -l -r -s haskell_clean_archi_for_free
psql -h localhost -p 5432 -U postgres -c "ALTER USER haskell_clean_archi_for_free WITH PASSWORD 'haskell_clean_archi_for_free';"
echo ""

echo "Creating schema etc."
psql -h localhost -p 5432 -U haskell_clean_archi_for_free -f migration.sql
echo ""

echo "You can now connect to postgres with : psql -h localhost -p 5432 -U postgres"
echo "Once logged in, to see what's in the haskell_clean_archi_for_free database : \c haskell_clean_archi_for_free "

exit 0