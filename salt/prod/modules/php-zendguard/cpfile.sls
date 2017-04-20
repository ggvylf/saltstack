zendguard-cpfile:
  file.managed:
    - name: /usr/lib64/php/modules/ZendGuardLoader.so
    - source: salt://modules.php-zendguard/files/ZendGuardLoader.so
    - user: root
    - group: root
    - mode: 0644
