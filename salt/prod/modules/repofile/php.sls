php-repo-copyfile:
  file.managed:
    - name: /etc/yum.repos.d/webtatic-php.repo
    - source: salt://modules.repofile/files/webtatic-php.repo
    - user: root
    - group: root
    - mode: 0644

