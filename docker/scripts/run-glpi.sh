#!/bin/sh

if [ -z "$(ls -A /var/www/glpi)" ]; then
    echo "glpi not initialized"
    echo "copy from /var/www/glpi-orig/"
    cp -rT /var/www/glpi-orig /var/www/glpi

    echo "copy glpi /var/lib/glpi/"
    cp -rT /var/www/glpi/files /var/lib/glpi

    echo "copy glpi etc/glpi"
    cp -rT /var/www/glpi/config /etc/glpi
    chown -R www-data:www-data /var/www/glpi/ /etc/glpi/ /var/lib/glpi/

    php /var/www/glpi/bin glpi:database:enable_timezones
fi

php-fpm
