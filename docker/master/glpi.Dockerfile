FROM php:8.2.9-fpm-alpine3.18

VOLUME /etc/glpi
VOLUME /var/lib/glpi
VOLUME /var/www/glpi

# Setup PHP
RUN curl -sSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions -o - | sh -s \
	# Mandatory additional packages check
	# https://glpi-install.readthedocs.io/en/latest/prerequisites.html#mandatory-extensions
	gd intl mysqli \ 
	# Optional extensions
	bz2 zip exif ldap opcache

# GLPI
RUN mkdir -p /var/www/glpi-orig
RUN wget https://github.com/glpi-project/glpi/releases/download/10.0.9/glpi-10.0.9.tgz -O - | tar -xzf - -C /var/www/glpi-orig --strip-components=1

RUN mkdir -p /etc/glpi /etc/glpi-orig /var/lib/glpi /var/lib/glpi-orig /var/log/glpi /var/www/glpi/marketplace /var/www/glpi-orig/marketplace

# RUN mv /var/www/glpi/files/ /var/lib/glpi
# RUN mv /var/www/glpi/config/ /etc/glpi

COPY [ \
	"./glpi-dockerfile/www/inc/downstream.php", \
	"/var/www/glpi-orig/inc/" \
]
COPY [ \
	"./glpi-dockerfile/config/local_define.php", \
	"/var/www/glpi/config/" \
]

RUN chown -R www-data:www-data /var/www/glpi/ /var/www/glpi-orig/ /etc/glpi/ /etc/glpi-orig/ /var/lib/glpi/ /var/lib/glpi-orig/ /var/log/glpi/

RUN mkdir -p /app/docker/scripts
COPY ./docker/scripts/run-glpi.sh /app/docker/scripts/
RUN chmod -R +x /app/docker/scripts/

CMD ["/app/docker/scripts/run-glpi.sh"]
# RUN chown -R www-data: /var/www/glpi/ /etc/glpi/ /var/lib/glpi/ /var/log/glpi/