include:
  - modules.makeenv.install

php-comp-pkg-install:
  pkg.installed:
    - pkgs:
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
      - gd
      - gd-devel
      - ImageMagick
      - ImageMagick-devel
      - uw-imap-devel
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
    - name:  cd /usr/local/src/php-{{ pillar['PHP_COMP_VERSION'] }} &&  ./configure --prefix={{ pillar['PHP_COMP_INSPATH'] }}/{{ pillar['PHP_COMP_DIRNAME'] }} --with-config-file-path={{ pillar['PHP_COMP_INSPATH'] }}/{{ pillar['PHP_COMP_DIRNAME'] }}/etc --with-config-file-scan-dir={{ pillar['PHP_COMP_INSPATH'] }}/{{ pillar['PHP_COMP_DIRNAME'] }}/etc  --with-pcre-regex  --enable-exif --enable-ftp --enable-zip --with-curl  --with-freetype-dir  --with-gd  --with-gettext  --with-iconv-dir  --with-kerberos  --with-libdir=lib64  --with-libxml-dir  --enable-mysqlnd  --with-openssl  --with-pcre-regex  --with-pdo-mysql  --with-pdo-sqlite  --with-pear  --with-png-dir --with-jpeg-dir  --with-xmlrpc  --with-xsl  --with-zlib   --with-imap --with-imap-ssl --enable-fpm  --enable-bcmath  --enable-libxml  --enable-inline-optimization  --enable-gd-native-ttf  --enable-mbregex  --enable-mbstring  --enable-pcntl  --enable-shmop  --enable-soap  --enable-sockets  --enable-sysvsem  --enable-xml --enable-fpm  --enable-opcache && make && make install && touch {{ pillar['PHP_COMP_INSPATH'] }}/{{ pillar['PHP_COMP_DIRNAME'] }}/installed.lock
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
    - unless:
      - test -f /etc/init.d/php-fpm

