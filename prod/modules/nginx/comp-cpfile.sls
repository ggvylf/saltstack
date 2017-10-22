nginx-comp-cpfile-nginx-conf:
   file.managed:
    - name: {{ pillar['NGINX_COMP_INSPATH'] }}/nginx/conf/nginx.conf
    - source: salt:///modules/nginx/files/comp-conf/nginx.conf
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - default:
      NGINXCOMPDIR: {{ pillar['NGINX_COMP_INSPATH'] }}
      WWWLOGDIR: {{ pillar['NGINX_COMP_INSPATH']}}/wwwlogs
      
#    - unless:
#      - test -f {{ pillar['NGINX_COMP_INSPATH'] }}/nginx/conf/nginx.conf

nginx-comp-cpfile-mkdir-conf-d:
  file.directory:
    - name: {{ pillar['NGINX_COMP_INSPATH'] }}/nginx/conf/conf.d/
    - user: root
    - group: root
    - dir_mode: 0755
    - file_mode: 0644
    - recurse:
      - user
      - group
      - mode
