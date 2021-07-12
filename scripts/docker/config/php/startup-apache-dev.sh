#!/bin/bash

# Workaround for permissions issues running the docker images on Ubuntu
usermod -u 1000 www-data

cd /var/www

# Clear cache
php flarum cache:clear

# Run migrations
php flarum migrate

# Publish all assets (FontAwesome, JS, CSS, etc)
php flarum assets:publish

# Make the environment variables available for cron
printenv | grep -v "no_proxy" >> /etc/environment

service cron start

apache2-foreground
