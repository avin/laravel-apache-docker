# Version: 0.0.1
FROM phusion/baseimage:0.9.15
MAINTAINER Avin Grape "carcinogen75@gmail.com"

# Install packages
RUN apt-get update
RUN apt-get install -y git curl wget apache2 php5 php5-mcrypt php5-json php5-mysql unzip build-essential

RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN apt-get install -y nodejs

RUN npm install -g gulp bower node-gyp

# Configure apache2
ADD default /etc/apache2/sites-available/000-default.conf
RUN /usr/sbin/a2enmod rewrite

# Configure PHP
RUN /usr/sbin/php5enmod mcrypt json

# Install composer
RUN /usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php
RUN /bin/mv composer.phar /usr/local/bin/composer

# Install laravel package
RUN mkdir /var/www/laravel
WORKDIR /var/www/laravel

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Create an `apache2` `runit` service
ADD apache2 /etc/sv/apache2
RUN update-service --add /etc/sv/apache2

EXPOSE 80

ADD run.sh /usr/local/sbin/run
ENTRYPOINT ["/sbin/my_init", "--", "/usr/local/sbin/run"]

