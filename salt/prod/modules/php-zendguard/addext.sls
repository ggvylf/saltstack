include:
  - modules.php-zendguard.cpfile

zendguard-editphpconf:
  file.append:
    - name: /etc/php.ini
    - text:
       - zend_extension=/usr/lib64/php/modules/ZendGuardLoader.so
       - zend_extension=/usr/lib64/php/modules/opcache.so
