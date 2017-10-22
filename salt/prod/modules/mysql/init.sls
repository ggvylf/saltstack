mariadb-install:
  pkg.installed:
    - names:
      - mariadb-server
      - mariadb
     

mariadb-service:
  service.running:
    - name: mariadb
    - enable: True
    - reload: True
    - require:
      - pkg: mariadb-install 
