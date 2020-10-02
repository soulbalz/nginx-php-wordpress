## Image Tag
- latest
- [WORDPRESS VERSION]: eg. `5.5.1`, `5.5`, `5.4.2`, `5.4`

## Environment variables

Variable              | Description
--------------------- |  ------------------------------------------------------------------------------
`CLI_SCRIPT`          | Predefined CLI script for service
`APPLICATION_UID`     | PHP-FPM UID (Effective user ID)
`APPLICATION_GID`     | PHP-FPM GID (Effective group ID)
`WEB_DOCUMENT_ROOT`   | Document root for Nginx
`WEB_DOCUMENT_INDEX`  | Document index (eg. `index.php`) for Nginx
`WEB_ALIAS_DOMAIN`    | Alias domains (eg. `*.vm`) for Nginx

## Filesystem layout

Directory                       | Description
------------------------------- | ------------------------------------------------------------------------------
`/opt/docker/etc/nginx`         | Nginx configuration
`/opt/docker/etc/nginx/ssl`     | Nginx ssl configuration with example server.crt, server.csr, server.key

File                                                | Description
--------------------------------------------------- | ------------------------------------------------------------------------------
`/opt/docker/etc/nginx/main.conf`                   | Main include file (will include `global.conf`, `php.conf` and `vhost.conf`) 
`/opt/docker/etc/nginx/global.conf`                 | Global nginx configuration options
`/opt/docker/etc/nginx/php.conf`                    | PHP configuration (connection to FPM)
`/opt/docker/etc/nginx/vhost.common.conf`           | Vhost common stuff (placeholder)
`/opt/docker/etc/nginx/vhost.conf`                  | Default vhost
`/opt/docker/etc/nginx/vhost.ssl.conf`              | Default ssl configuration for vhost
`/opt/docker/etc/php/fpm/php-fpm.conf`              | PHP FPM daemon configuration
`/opt/docker/etc/php/fpm/pool.d/application.conf`   | PHP FPM pool configuration

## More info
- https://webdevops.io/projects/dockerfiles/
- https://hub.docker.com/_/wordpress