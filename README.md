# Pareyshop
Zum Starten des Containers
```bash
./run.sh
```
# Installation
Vor der ersten Installation muss die .env.local Datei erstellt werden. Dazu die .env.example kopieren und anpassen.
```bash
cp .env.example .env.local
```
Für den Localhost wird ein Zertifikat benötigt. Dieses kann mit folgendem Befehl erstellt werden.
```bash
openssl req -x509 -out nginx/ssl/localhost.crt -keyout nginx/ssl/localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
```
SourceCode aus dem Dump einspielen
```bash
docker exec -i pareyshop-db-1 mysql -u root -pexampledb < dumpsql/pareyshop.sql
```
Datenbank Import
```bash
docker exec -i pareyshop-db-1 mysql -u root -pexampledb < dumpsql/pareyshop.sql
```

## Import Dump Sql
Die Importdatei .sql muss in dem Ordner dumpsql liegen. Dieser wird in den Datenbank Container im Verzeichniss /opt/dumpsql gemountet.
<br>
Auf Container der DB verbinden, z.B. mit cShell in der zshrc Config
```
function cShell {
docker container exec -it $1 /bin/sh
}
```
<br>
Zum Importieren folgenden Befehl. Die Passwörter können in der docker-compose nachgesehen werden.

```bash
mariadb -u root -p exampledb < /opt/dumpsql/030124.sql
```

Manchmal gibt es folgenden Fehler
```
ERROR 1193 (HY000) at line 2146: Unknown system variable 'GTID_PURGED'
```
Dann folgende Korrektur auf dem DB-Container ausführen
```bash
sed -i '/@@GLOBAL.GTID_PURGED=/d' yoursql.sql
```

## Symfony

### Composer install
Bei der ersten Verwendung Composer installieren
```bash
docker compose run --rm composer install
```
Später einfach updaten
```bash
docker compose run --rm composer update
```

```bash
composer create-project symfony/skeleton:"6.3.*" src
```

Datenbankänderung für Werbung
```
ALTER TABLE exampledb.post ADD ending datetime DEFAULT NULL NULL;
ALTER TABLE exampledb.post ADD advertising BOOL DEFAULT 0 NULL;
```