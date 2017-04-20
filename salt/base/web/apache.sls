apache-install:
  pkg.installed:
    - names:
      - {{ pillar['apache'] }}

apache.service:
  service.running:
    - names:
      - {{ pillar['apache'] }}
    - enable: True

