## Build project
To build project run:
```
docker compose --file .\docker\master\docker-compose.yaml build
```

glpi image have name convention *"${DOCKER_REGISTRY}glpi_inlaze"* where DOCKER_REGISTRY is docker host where docker image is stored

## Run App
Every service requires an specific configuration before to up
### DB
create a init.sql file at root of project folder (follow init-template.sql) and set **db username**, **db name** and **password** for db username

### Proxy
Check proxy confs are at *proxy/confs* folder and have expected server_name

Ensure the ssl files are located at *proxy/sll*

### GLPI
Once docker image is ready ensure exist and are empty the next folders:
- mysql
- glpi/etc/glpi
- glpi/lib/glpi
- glpi/www/glpi


Also add the php config files (follow glpi-template folder) with the same folder structure and file names like this:
- glpi/php/conf.d/opcache.ini
- glpi/php/php.ini

Run the next command to run all system
```
docker compose --file .\docker\master\docker-compose.yaml up --pull=always --detach=true
```

### GLPI first time
If is firts time wait to service initialization (Folders copy that run the docker script) then go to the host that is configured on *server_name* of proxy conf and follow steps. When database info is requested add the following info:

- Database host: inlaze_glpi-glpi-1
- Database name: glpi_db (Same that you setup on init.sql)
- Database user: glpi_user
- Database User password: *password here CHANGE* (Check init-template.sql and setup password for user before to execute)


If everything is ok you will see the default users and passwords
```
Default logins / passwords are:

glpi/glpi for the administrator account
tech/tech for the technician account
normal/normal for the normal account
post-only/postonly for the postonly account
You can delete or modify these accounts as well as the initial data.
```

### Timezone
https://glpi-install.readthedocs.io/en/latest/timezones.html

#### Database
Intialize timezones from os
```
mysql_tzinfo_to_sql /usr/share/zoneinfo/right |mysql -u root mysql -p
```

Then grant access to timezone names
```
GRANT SELECT ON `mysql`.`time_zone_name` TO 'glpi_user'@'localhost';
GRANT SELECT ON `mysql`.`time_zone_name` TO 'glpi_user'@'%';
FLUSH PRIVILEGES;
```
