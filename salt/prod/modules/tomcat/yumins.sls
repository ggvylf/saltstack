tomcat-yum-install:
  pkg.installd:
   - name:
     - tomcat


tomcat-yum-service:
  service-running:
   - name: tomcat
   - enable: True
   - reload: True
   - require:
    - pkg: tomcat-yum-install
    - file: tomcat-yum-config


