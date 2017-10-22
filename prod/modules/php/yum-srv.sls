include:
  - modules.php.yum-ins
  - modules.php.yum-cpconf

php-service:
   service.running:
     - name: php-fpm
     - enable: True
     - reload: True
     - require:
       - pkg: php-yum-install
