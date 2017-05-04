nginx-comp-cpfile-nginx-conf:
   file.managed:
    - name: {{ pillar['NGINX_COMP_INSPATH'] }}/nginx/conf/nginx.conf
    - source: salt:///modules/nginx/files/comp-conf/nginx.conf
    - user: root
    - group: root
    - mode: 0644
#    - unless:
#      - test -f {{ pillar['NGINX_COMP_INSPATH'] }}/nginx/nginx.conf

