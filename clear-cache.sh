#!/bin/bash
docker exec -it flarumite-svc php flarum cache:clear
docker exec -it flarumite-svc php flarum assets:publish
