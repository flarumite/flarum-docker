#!/bin/bash

chmod -R 755 /var/www

# Clear cache - this is essential once we mount the EFS volume
cd /var/www && php flarum cache:clear

# We will also need to add the running of migrations here
cd /var/www && php flarum migrate

# Symlink fonts
# ln -sF /var/www/vendor/components/font-awesome/webfonts /var/www/public/assets/fonts

# Make the environment variables available for cron
printenv | grep -v "no_proxy" >> /etc/environment

service cron start

apache2-foreground