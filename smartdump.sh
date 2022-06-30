#!/bin/bash

aws_rds_host=''
application_user=''
application_password=''

pg_port=''
pg_user=''
database=$1
files_path=''
sql_query="INSERT INTO your_user_table(username, email, password) VALUES ('"$application_user"', '$application_user@your_company.com.br', '$application_password');"

export PGPASSWORD=''

if [ "$EUID" != 0 ]; then
    sudo "$0" "$@"
fi

cd $files_path

if ! [ -f "$files_path/$database.gz" ]; then
  echo "Dumping database '$database' to '$database.gz'..."
 pg_dump -v -h $aws_rds_host -p $pg_port -U $pg_user -w --exclude-table-data='tables_to_exclude*' $database | gzip > $database.gz
fi

sudo -u postgres psql -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE pid <> pg_backend_pid() AND datname = '$database';" 

echo "Creating local database '$database'..."
sudo -u postgres psql -c "drop database $database;"
sudo -u postgres psql -c "create database $database;"

echo "Grant previleges on '$database' to '$pg_user'..."
sudo -u postgres psql -c "grant all privileges on database $database to $pg_user;"

echo "Restorig '$database.gz' to local database '$database'..."
gunzip -c $database.gz | psql -h localhost -U $pg_user -w $database

echo "Inserting '$application_user' to local database '$database'..."
sudo -u postgres psql -d $database -c "$sql_query"

unset PGPASSWORD
