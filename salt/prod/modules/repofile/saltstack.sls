saltstach-repo-copyfile:
  file.managed:
    - name: /etc/yum.repos.d/salt-latest.repo
    - source: salt://modules/repofile/files/salt-latest.repo
    - user: root
    - group: root
    - mode: 0644

