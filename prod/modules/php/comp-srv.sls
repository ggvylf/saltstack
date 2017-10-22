include:
 - modules.php.comp-ins
 - modules.php.comp-cpfile
 - modules.php.comp-ext-ins


php-comp-service:
  cmd.run:
    - name: /etc/init.d/php-fpm start
php-comp-service-enable:
  cmd.run:
    - name: systemctl enable php-fpm
