#!/usr/bin/env zsh


docker compose up testdb -d
docker compose run --rm console app:FixturesReload --env=test
docker compose run --rm phpunit tests

echo "Success!"