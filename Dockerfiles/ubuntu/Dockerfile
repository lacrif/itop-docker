# syntax=docker/dockerfile:1
ARG ITOP_VERSION=3.2.0
ARG ITOP_DOWNLOAD_URL=https://sourceforge.net/projects/itop/files/itop/3.2.0-2/iTop-3.2.0-2-14758.zip/download

FROM ubuntu:24.04

ARG ITOP_VERSION
ARG ITOP_DOWNLOAD_URL

LABEL org.opencontainers.image.authors="lacrif" \
      org.opencontainers.image.description="iTop web-interface based on Apache2 web server with MySQL database support" \
      org.opencontainers.image.documentation="https://www.itophub.io/wiki/page" \
      org.opencontainers.image.licenses="GNU Affero General Public License v3.0" \
      org.opencontainers.image.title="iTop web-interface (Apache, MySQL)" \
      org.opencontainers.image.url="https://www.combodo.com/" \
      org.opencontainers.image.vendor="Combodo" \
      org.opencontainers.image.version="${ITOP_VERSION}"

# Install system dependencies
RUN apt-get update
RUN apt-get install -y curl zip unzip supervisor graphviz 
RUN apt-get install -y apache2 libapache2-mod-php
RUN apt-get install -y php php-mysql php-cli php-json php-xml php-gd php-zip php-curl php-soap php-mbstring php-apcu php-ldap php-imap 
ENV PHP_INI_DIR=/etc/php/8.3/cli

# Prepare apache2
RUN rm -rf /var/www/html
RUN rm -f /etc/apache2/sites-available/*
RUN rm -f /etc/apache2/sites-enabled/*
RUN sed -ri \
            -e 's!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g' \
            -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' \
        "/etc/apache2/apache2.conf"
RUN sed -ri \
            -e 's!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g' \
            -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' \
        "/etc/apache2/conf-available/other-vhosts-access-log.conf"

# Copy config
COPY ["conf/etc/", "/etc/"]

# Enable Apache mods
RUN a2enmod ssl
RUN a2enmod headers

# Get iTop and fix rights
RUN curl -SL -o /tmp/itop.zip ${ITOP_DOWNLOAD_URL}
RUN unzip /tmp/itop.zip "web/*" -d /var/www/itop
RUN rm -f /tmp/itop.zip
RUN mv /var/www/itop/web/*  /var/www/itop
RUN rmdir /var/www/itop/web
RUN mkdir /var/www/itop/env-production /var/www/itop/env-production-build /var/www/itop/env-test /var/www/itop/env-test-build
RUN chown -R www-data:www-data /var/www/itop

# Set working directory
WORKDIR /var/www/itop

# Set custom entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
