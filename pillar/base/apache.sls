{% if grains['os']=='CentOS' %}
apache: httpd
{% elif grains['os']=="Dabian" %}
apache: apache2
{% endif %}

