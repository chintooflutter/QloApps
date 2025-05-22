FROM php:7.4-apache

# Install system packages needed by PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libonig-dev libxml2-dev unzip zip \
    libzip-dev mariadb-client

# Install PHP extensions including ZIP and SOAP
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd soap zip

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set PHP configuration values
RUN echo "upload_max_filesize=16M" > /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size=16M" >> /usr/local/etc/php/conf.d/uploads.ini

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . /var/www/html

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
