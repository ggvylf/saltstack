/etc/yum.repos.d/:
  file.recurse:
    - source : salt://init/files
    - user: root
    - group: root
