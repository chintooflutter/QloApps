FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libonig-dev libxml2-dev unzip zip mariadb-client \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

RUN a2enmod rewrite

WORKDIR /var/www/html

COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
