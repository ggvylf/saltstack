php-comp-cpfile-php-ini:
   file.managed:
    - name: {{ pillar['PHP_COMP_INSPATH']  }}/php/etc/php.ini
    - source: salt:///modules/php/files/comp-conf/php.ini
    - user: root
    - group: root
    - mode: 0755
#    - unless:
#      - test -f {{ pillar['PHP_COMP_INSPATH']  }}/etc/php.ini

php-comp-cpfile-php-fpm-conf:
   file.managed:
    - name: {{ pillar['PHP_COMP_INSPATH']  }}/php/etc/php-fpm.conf
    - source: salt:///modules/php/files/comp-conf/php-fpm.conf
    - user: root
    - group: root
    - mode: 0755
#    - unless:
#      - test -f {{ pillar['PHP_COMP_INSPATH']  }}/php/etc/php-fpm.conf

php-comp-cpfile-www-conf:
   file.managed:
    - name: {{ pillar['PHP_COMP_INSPATH']  }}/php/etc/php-fpm.d/www.conf
    - source: salt:///modules/php/files/comp-conf/www.conf
    - user: root
    - group: root
    - mode: 0755
#    - unless:
#      - test -f {{ pillar['PHP_COMP_INSPATH']  }}/php/etc/php-fpm.d/www.conf

