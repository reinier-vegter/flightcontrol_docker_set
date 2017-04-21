FROM drupal:7-apache

RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN apt-get update && apt-get install drush -y


# BBC's wraith
RUN apt-get install bzip2 libicu-dev imagemagick rake ruby-dev zlib1g-dev patch
RUN cd /opt \
  && curl -vL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 > phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  &&  unzip phantomjs-2.1.1-linux-x86_64.tar.bz2 && rm phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  && ln -s $(pwd)/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
RUN gem install wraith

