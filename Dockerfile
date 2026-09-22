FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Zona horaria del sistema operativo (Lima)
RUN ln -fs /usr/share/zoneinfo/America/Lima /etc/localtime && \
    apt-get update && apt-get install -y tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    rm -rf /var/lib/apt/lists/*

# PHP 8.4
RUN add-apt-repository ppa:ondrej/php -y && \
    apt-get update && apt-get install -y \
    php8.4 \
    php8.4-cli \
    php8.4-mysql \
    php8.4-xml \
    php8.4-mbstring \
    php8.4-curl \
    php8.4-zip \
    php8.4-bcmath \
    php8.4-gd \
    && rm -rf /var/lib/apt/lists/*

# Zona horaria PHP
RUN echo "date.timezone = America/Lima" > /etc/php/8.4/mods-available/timezone.ini && \
    phpenmod timezone

# Node 20 + npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Git + Apache + PHP Module
RUN apt-get update && apt-get install -y \
    git \
    apache2 \
    libapache2-mod-php8.4 \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

# SQL Server ODBC Driver 17 
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

RUN curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list \
    > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update

RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17

# PHP SQL Server Extensions
RUN apt-get install -y \
    php8.4-dev \
    php-pear \
    unixodbc-dev \
    gcc \
    g++ \
    make \
    autoconf \
    && rm -rf /var/lib/apt/lists/*

RUN pecl install sqlsrv pdo_sqlsrv

RUN echo "extension=sqlsrv.so" > /etc/php/8.4/mods-available/sqlsrv.ini && \
    echo "extension=pdo_sqlsrv.so" > /etc/php/8.4/mods-available/pdo_sqlsrv.ini

RUN phpenmod sqlsrv pdo_sqlsrv

# Compatibilidad SQL Server 2014: baja el nivel de seguridad TLS del sistema completo
RUN sed -i 's/@SECLEVEL=2/@SECLEVEL=0/g' /etc/ssl/openssl.cnf

WORKDIR /var/www/html

EXPOSE 80

CMD ["apachectl","-D","FOREGROUND"]