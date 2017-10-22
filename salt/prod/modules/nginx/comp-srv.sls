include:
 - modules.nginx.comp-ins
 - modules.nginx.comp-cpfile

nginx-comp-service:
  cmd.run:
    - name: /etc/init.d/nginx start

nginx-comp-service-enable:
  cmd.run:
    - name: systemctl enable nginx
