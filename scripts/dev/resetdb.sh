#!/bin/sh
export MYSQL_PWD=root
connection="mysql --max-allowed-packet=1073741824 -h 0.0.0.0 --user=root flarum --port=3306"

echo "Resetting local DB"
$connection < ./build/dev/reset_schema.sql
echo "Applying schema from repo"
$connection < ./build/dev/flarum_dev.sql
export MYSQL_PWD=''
echo "Ensuring deps are up to date"
composer install
echo "Complete, enjoy using Flarum :-)\n"
