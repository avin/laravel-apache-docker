# Version: 0.0.1
FROM phusion/baseimage:0.9.15
MAINTAINER Avin Grape "carcinogen75@gmail.com"

# Install packages
RUN apt-get update
RUN apt-get install -y git curl wget apache2 php5 php5-mcrypt php5-json unzip
RUN apt-get -y autoremove 
RUN apt-get clean

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
RUN curl -L https://github.com/laravel/laravel/archive/master.zip -o temp.zip; \
	unzip temp.zip; rm temp.zip; mv ./laravel-master/* ./
RUN /bin/chown www-data:www-data -R /var/www/laravel/app/storage

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
