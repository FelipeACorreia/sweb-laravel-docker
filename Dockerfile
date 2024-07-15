FROM php:8.0-fpm-alpine

WORKDIR /var/www/html

# Copy composer from the latest composer image
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Add the install-php-extensions script
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

# Make the script executable and install PHP extensions
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions pdo pdo_mysql gd zip exif

# Install additional PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql exif

# Install Node.js and npm
RUN apk add --no-cache nodejs npm

# Optionally, you can verify the installation
RUN node -v && npm -v

