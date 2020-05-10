# flarumite/flarum-docker

### Usage

From the root of the repo:

```
composer install
docker-compose build
docker-compose up
```

#### Flarum
The Flarum installation will be available at `http://localhost:8001`

Default credentials:
- flarumite/flarumite (admin user)
- moderator/flarumite (moderator user)
- user/flarumite (standard user)

##### Resetting the DB
If you find yourself in a position that you need to reset the DB to a known good state, or to apply any changes that have been added to the repo:
```
./scripts/dev/resetdb.sh
```
Note: requires `mysql-client` to be available locally

#### PHPMyAdmin
PMA can be accessed at `http://localhost:8002`

Default credentials:
- flarum/flarum
