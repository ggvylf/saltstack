include:
  - modules.repofile.saltstack

salt-minion-install:
  pkg.installed:
   - pkgs:
     - salt-minion
   - require:
     - file: saltstach-repo-copyfile

salt-minion-add-host:
  cmd.run:
    - name: echo {{ grains['fqdn_ip4'] }}  {{ grains['fqdn'] }} >> /etc/hosts
  file.append:
    - name: /etc/hosts
    - text:
      - "{{ grains['fqdn_ip4'] }}  {{ grains['fqdn'] }}"

salt-minion-service:
  service.running:
    - name: salt-minion
    - enable: True
    - reload: True
