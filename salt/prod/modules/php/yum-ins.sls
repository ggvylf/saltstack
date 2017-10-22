include:
  - modules.repofile.php

php-yum-install:
  pkg.installed:
    - pkgs:
      - php{{ pillar['PHP_YUM_VERSION']  }}
      - php{{ pillar['PHP_YUM_VERSION']  }}-bcmath
      - php{{ pillar['PHP_YUM_VERSION']  }}-fpm
      - php{{ pillar['PHP_YUM_VERSION']  }}-gd
      - php{{ pillar['PHP_YUM_VERSION']  }}-mbstring
      - php{{ pillar['PHP_YUM_VERSION']  }}-pdo
      - php{{ pillar['PHP_YUM_VERSION']  }}-mysqlnd
      - php{{ pillar['PHP_YUM_VERSION']  }}-xml
      - php{{ pillar['PHP_YUM_VERSION']  }}-opcache
      - php{{ pillar['PHP_YUM_VERSION']  }}-mcrypt
      - php{{ pillar['PHP_YUM_VERSION']  }}-snmp
    - require:
      - file: php-repo-copyfile 

