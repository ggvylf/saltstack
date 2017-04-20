php-www-conf:
  file.managed:
    - name: /etc/php-fpm.d/www.conf
    - source: salt://modules/php/files/php-yum-www.conf
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: php-yum-install

php-php-ini-conf:
   file.managed:
    - name: /etc/php.ini
    - source: salt://modules/php/files/php-yum-php.ini
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: php-yum-install

