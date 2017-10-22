lamp-install:
  pkg.installed:
    - pkgs:
      - httpd
      - php
      - php-pdo
      - php-mysqlnd

apache-config:
   file.managed:
     - name: /etc/httpd/conf/httpd.conf
     - source: salt://web/httpd.conf
     - user: root
     - group: root
     - mode: 0644

php-config::
  file.managed:
    - name: /etc/php.ini
    - source: salt://web/php.ini
    - user: root
    - group: root
    - mode: 0644


