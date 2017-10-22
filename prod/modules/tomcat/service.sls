include:
  - modules.tomcat.install

tomcat-service:
   cmd.run:
    - name: export JAVA_HOME={{ pillar['JDK_INSPATH']  }}/jdk && {{ pillar['TOMCAT_INSPATH'] }}/tomcat/bin/startup.sh 
    - unless:
      - lsof -i:8080
