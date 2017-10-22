include:
  - init.yum-repo

zabbix-server:
  pkg.installed:
    - names:
      - zabbix-web-mysql
      - zabbix-server-mysql
    - require:
      - file: /etc/yum.repos.d/
  file.managed:
    - name: /etc/zabbix_server.conf
    - source: salt://zabbix/files/zabbix_agentd.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      ZABBIX_SERVER: 192.168.56.11
      AGENT_HOSTNAME: {{grains['fqdn']}}
    - require:
      - pkg: zabbix-server
  service.running:
    - name: zabbix-server
    - enable: True
    - watch:
      - file: zabbix-server
      - pkg: zabbix-server

