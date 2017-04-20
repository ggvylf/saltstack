zendguard-cpfile:
  file.managed:
    - name: /usr/lib64/php/modules/ZendGuardLoader.so
    - source: salt://modules.php-zendguard/files/ZendGuardLoader.so
    - user: root
    - group: root
    - mode: 0644

zendguard-editphpconf:
  file.append:
    - name: /etc/php.ini
    - text:
       - zend_extension=/usr/lib64/php/modules/ZendGuardLoader.so
       - zend_extension=/usr/lib64/php/modules/opcache.so
    - require:
      - file: zendguard-cpfile
