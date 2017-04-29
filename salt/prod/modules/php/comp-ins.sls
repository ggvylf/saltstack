include:
  - modules.makeenv.install

php-comp-pkg-install:
  pkg.installed:
    - pkgs:
      - openjpeg
      - openjpeg-devel
      - mcrypt
      - php-mcrypt
      - libmcrypt
      - libmcrypt-devel
      - mariadb-devel
      - libjpeg-turbo
      - libjpeg-turbo-devel
      - libmemcached
      - libmemcached-devel
      - libpng
      - libpng-devel
      - freetype
      - freetype-devel
      - libxml2
      - libxml2-devel
      - zlib-devel
      - ImageMagick
      - ImageMagick-devel
      - uw-imap-devel
      - icu
      - libicu
      - libicu-devel


    - require:
      - pkg: makeenv-install

php-comp-cpfile:
  file.managed:
    - name: /usr/local/src/php-{{ pillar['PHP_COMP_VERSION'] }}.tar.gz
    - source: salt://modules/php/files/php-{{ pillar['PHP_COMP_VERSION'] }}.tar.gz
    - user: root
    - group: root
    - mode: 0644
    - unless:
      - test -f /usr/local/src/php-{{ pillar['PHP_COMP_VERSION'] }}.tar.gz


php-comp-tarfile:
  cmd.run:
    - name: tar xf /usr/local/src/php-{{ pillar['PHP_COMP_VERSION'] }}.tar.gz  -C /usr/local/src/
    - require:
      - file: php-comp-cpfile
    - unless:
      - test -d /usr/local/src/php-{{ pillar['PHP_COMP_VERSION'] }}

php-comp-mkdir:
  cmd.run:
    - name: mkdir -p {{ pillar['PHP_COMP_INSPATH'] }}


php-comp-install:
  cmd.run:
    - name:  cd /usr/local/src/php-{{ pillar['PHP_COMP_VERSION'] }} &&  ./configure --prefix={{ pillar['PHP_COMP_INSPATH'] }}/{{ pillar['PHP_COMP_DIRNAME'] }} --with-config-file-path={{ pillar['PHP_COMP_INSPATH'] }}/{{ pillar['PHP_COMP_DIRNAME'] }}/etc --with-mcrypt=/usr/include --enable-mysqlnd --with-gd --with-iconv-dir --with-curl --with-zlib --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-mbregex --enable-fpm --enable-exif --enable-intl --enable-mbstring --enable-ftp --enable-gd-native-ttf --with-openssl --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-gettext --with-curl --with-jpeg-dir --with-freetype-dir --with-mysqli --with-xsl --enable-embedded-mysqli --with-pdo-mysql  && make && make install && touch {{ pillar['PHP_COMP_INSPATH'] }}/{{ pillar['PHP_COMP_DIRNAME'] }}/installed.lock
    - unless:
      - test -f {{ pillar['PHP_COMP_INSPATH'] }}/{{ pillar['PHP_COMP_DIRNAME'] }}/installed.lock
    - require:
      - cmd: php-comp-mkdir


php-comp-symlink:
  file.symlink:
    - name: {{ pillar['PHP_COMP_INSPATH']  }}/php
    - target: {{ pillar['PHP_COMP_INSPATH']  }}/{{ pillar['PHP_COMP_DIRNAME'] }}
    - require:
      - cmd: php-comp-install

php-comp-sevscript-cpfile:
  file.managed:
    - name: /etc/init.d/php-fpm
    - source: salt://modules/php/files/php-srv-script.sh
    - user: root
    - group: root
    - mode: 0755
    - template: jinja
    - default:
      PHPINSDIR: {{ pillar['PHP_COMP_INSPATH'] }}/{{ pillar['PHP_COMP_DIRNAME'] }}
    - unless:
      - test -f /etc/init.d/php-fpm

