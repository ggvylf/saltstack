include:
  - modules.makeenv.install
  - modules.users.www

nginx-comp-pkg-install:
  pkg.installed:
    - pkgs:
      - pcre
      - pcre-devel 
      - openssl 
      - openssl-devel
      - zlib 
      - zlib-devel
      - gcc
      - gcc-c++
      - ncurses-devel
      - perl
    - require:
      - pkg: makeenv-install

nginx-comp-cpfile:
  file.managed:
    - name: /usr/local/src/nginx-{{ pillar['NGINX_COMP_VERSION'] }}.tar.gz
    - source: salt://modules/nginx/files/nginx-{{ pillar['NGINX_COMP_VERSION'] }}.tar.gz
    - user: root
    - group: root
    - mode: 0644
    - unless:
      - test -f /usr/local/src/nginx-{{ pillar['NGINX_COMP_VERSION'] }}.tar.gz


nginx-comp-tarfile:
  cmd.run:
    - name: tar xf /usr/local/src/nginx-{{ pillar['NGINX_COMP_VERSION'] }}.tar.gz  -C /usr/local/src/
    - require:
      - file: nginx-comp-cpfile
    - unless:
      - test -d /usr/local/src/nginx-{{ pillar['NGINX_COMP_VERSION'] }}

nginx-comp-mkdir:
  cmd.run:
    - name: mkdir -p {{ pillar['NGINX_COMP_INSPATH'] }}

nginx-comp-mkdir-wwwroot:
  file.directory:
    - name: {{ pillar['NGINX_COMP_INSPATH'] }}/wwwroot
    - user: www
    - group: www
    - dir_mode: 755
    - file_mode: 644
    - rescuse:
      - user
      - group
      - mode

nginx-comp-mkdir-wwwlogs:
  file.directory:
    - name: {{ pillar['NGINX_COMP_INSPATH'] }}/wwwlogs
    - user: www
    - group: www
    - dir_mode: 755
    - file_mode: 644
    - rescuse:
      - user
      - group
      - mode
  

nginx-comp-install:
  cmd.run:
    - name:  cd /usr/local/src/nginx-{{ pillar['NGINX_COMP_VERSION'] }} &&  ./configure --prefix={{ pillar['NGINX_COMP_INSPATH'] }}/{{ pillar['NGINX_COMP_DIRNAME'] }} --user=www --group=www --with-pcre --with-http_ssl_module --with-http_gzip_static_module --with-http_stub_status_module --with-http_v2_module  && make && make install && touch {{ pillar['NGINX_COMP_INSPATH'] }}/{{ pillar['NGINX_COMP_DIRNAME'] }}/installed.lock
    - unless:
      - test -f {{ pillar['NGINX_COMP_INSPATH'] }}/{{ pillar['NGINX_COMP_DIRNAME'] }}/installed.lock
    - require:
      - cmd: nginx-comp-mkdir


nginx-comp-symlink:
  file.symlink:
    - name: {{ pillar['NGINX_COMP_INSPATH']  }}/nginx
    - target: {{ pillar['NGINX_COMP_INSPATH']  }}/{{ pillar['NGINX_COMP_DIRNAME'] }}
    - require:
      - cmd: nginx-comp-install

nginx-comp-sevscript-cpfile:
  file.managed:
    - name: /etc/init.d/nginx
    - source: salt://modules/nginx/files/nginx-srv-script.sh
    - user: root
    - group: root
    - mode: 0755
    - template: jinja
    - default:
      NGINXINSDIR: {{ pillar['NGINX_COMP_INSPATH'] }}/{{ pillar['NGINX_COMP_DIRNAME'] }}
    - unless:
      - test -f /etc/init.d/nginx

