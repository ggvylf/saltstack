include:
  - modules.repofile.saltstack

salt-minion-install:
  pkg.installed:
   - pkgs:
     - salt-minion
   - require:
     - file: saltstach-repo-copyfile

salt-minion-add-host:
  file.append:
    - name: /etc/hosts
    - text:
      - {{ grains['ip4_interfaces']['eth0'][0]}}  {{ grains['fqdn'] }}

salt-minion-cpconf:
  file.managed:
    - name: /etc/salt/minion
    - source: salt://modules/saltminion/files/salt-minion.conf
    - user: root
    - group: root
    - mode: 0640
    - template: jinja
    - defaults:
      SALTMASTER: 192.168.56.11


salt-minion-service:
  service.running:
    - name: salt-minion
    - enable: True
    - watch:
      - file: salt-minion-cpconf
