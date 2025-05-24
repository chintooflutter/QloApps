FROM php:7.4-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libonig-dev libxml2-dev unzip zip \
    libzip-dev mariadb-client \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd soap zip

# Enable Apache rewrite module
RUN a2enmod rewrite

# Configure PHP settings
RUN echo "upload_max_filesize=16M" > /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size=16M" >> /usr/local/etc/php/conf.d/uploads.ini

# Set working directory
WORKDIR /var/www/html

# Copy QloApps source code into container
COPY . /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
