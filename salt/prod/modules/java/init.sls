jdk-cpfile:
  file.managed:
    - name: /usr/local/src/jdk-{{ pillar['JDK_VERSION'] }}-linux-x64.tar.gz
    - source: salt://java/files/jdk-{{ pillar['JDK_VERSION']  }}-linux-x64.tar.gz
    - user: root
    - group: root
    - mode: 0644
    - unless:
      - test -f /usr/local/src/jdk-{{ pillar['JDK_VERSION']  }}-linux-x64.tar.gz

jdk-tarfile:
  cmd.run:
    - name: /usr/bin/tar xf /usr/local/src/jdk-{{ pillar['JDK_VERSION']  }}-linux-x64.tar.gz -C {{ pillar['JDK_INSPATH']  }}
    - unless:
      - test -d  {{ pillar['JDK_INSPATH'] }}/{{ pillar['JDK_DIRNAME']  }}

jdk-symlink:
  file.symlink:
    - name: {{ pillar['JDK_INSPATH'] }}/jdk
    - target: {{ pillar['JDK_INSPATH'] }}/{{ pillar['JDK_DIRNAME'] }}
    - unless:
      - test -s {{ pillar['JDK_INSPATH'] }}/jdk


jdk-envfile:
  file.managed:
    - name: /etc/profile.d/jdk.sh
    - source: salt://java/files/jdk.sh
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - defaults:
      JDKDIR: {{ pillar['JDK_INSPATH'] }}

  cmd.run:
    - name: source /etc/profile.d/jdk.sh
    - require:
      - file: jdk-envfile

