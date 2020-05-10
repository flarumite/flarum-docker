#!/bin/bash

chmod -R 755 /var/www

# Clear cache - this is essential once we mount the EFS volume
cd /var/www && php flarum cache:clear

# We will also need to add the running of migrations here
cd /var/www && php flarum migrate

# Pre-compile assets
cd /var/www && php flarum cache:assets --css --js --locales

# Make the environment variables available for cron
printenv | grep -v "no_proxy" >> /etc/environment

service cron start

apache2-foreground