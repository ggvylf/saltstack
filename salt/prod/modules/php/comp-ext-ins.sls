php-ext-copy:
  file.recurse:
    - name: /data/php/lib/php/extensions/no-debug-non-zts-20160303/
    - source: salt://modules/php/files/ext
    - user: root
    - group: root
    - file_mode: 755


php-ext-conf:
  file.append:
    - name: /data/php/etc/php.ini
    - text:
      - '[opcache]'
      - zend_extension=opcache.so
      - '[imagick]'
      - extension=imagick.so
      - '[memcached]'
      - extension=memcached.so
      - '[phalcon]'
      - extension=phalcon.so
      - '[redis]'
      - extension=redis.so
      - '[grpc]'
      - extension=grpc.so

php-composer-copy:
  file.managed:
    - name: /usr/local/bin/composer
    - source: salt://modules/php/files/ext/composer
    - user: root
    - group: root
    - mode: 0755

