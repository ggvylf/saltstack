include:
  - modules.java.init

tomcat-cpfile:
  file.managed:
    - name: /usr/local/src/apache-tomcat-{{ pillar['TOMCAT_VERSION'] }}.tar.gz
    - source: salt://modules/tomcat/files/apache-tomcat-{{ pillar['TOMCAT_VERSION'] }}.tar.gz
    - user: root
    - group: root
    - mode: 0644
    - unless:
      - test -f /usr/local/src/apache-tomcat-{{ pillar['TOMCAT_VERSION']  }}.tar.gz

tomcat-tarfile:
  cmd.run:
    - name: /usr/bin/tar xf /usr/local/src/apache-tomcat-{{ pillar['TOMCAT_VERSION']  }}.tar.gz  -C {{ pillar['TOMCAT_INSPATH'] }}   
    - unless:
      - test -d {{ pillar['TOMCAT_INSPATH']  }}/apache-tomcat-{{ pillar['TOMCAT_VERSION'] }}


tomcatl-symlink:
  file.symlink:
    - name: {{ pillar['TOMCAT_INSPATH']  }}/tomcat
    - target: {{ pillar['TOMCAT_INSPATH']  }}/{{ pillar['TOMCAT_DIRNAME'] }}
    - unless:
      - test -s {{ pillar['TOMCAT_INSPATH'] }}/tomcat


tomcat-envfile:
  file.managed:
    - name: /etc/profile.d/tomcat.sh
    - source: salt://modules/tomcat/files/tomcat.sh
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - defaults:
       TOMCATDIR: {{ pillar['TOMCAT_INSPATH'] }}

  cmd.run:
    - name: source /etc/profile.d/tomcat.sh
    - require:
      - file: tomcat-envfile

tomcat-rm-manager:
  file.absent:
    - name: {{ pillar['TOMCAT_INSPATH'] }}/tomcat/webapps/manager

tomcat-rm-host-manager:
  file.absent:
   - name: {{ pillar['TOMCAT_INSPATH'] }}/tomcat/webapps/host-manager
