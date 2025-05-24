FROM php:7.4-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libonig-dev libxml2-dev unzip zip libzip-dev mariadb-client && \
    docker-php-ext-configure gd --with-jpeg && \
    docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd soap zip && \
    a2enmod rewrite

# Set PHP upload limits
RUN echo "upload_max_filesize=16M" > /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size=16M" >> /usr/local/etc/php/conf.d/uploads.ini

# Set working directory
WORKDIR /var/www/html

# Copy project files into container
COPY . /var/www/html

# Set correct permissions for Apache
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
