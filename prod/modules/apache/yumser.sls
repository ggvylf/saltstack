apache-yum-service:
   service.running:
     - name: httpd
     - enable: True
     - reload: True
     - require:
       - pkg: apache-install
       - file: apache-config
