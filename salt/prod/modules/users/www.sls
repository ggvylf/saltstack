{% set USERNAME = 'www' %}
{% set GROUPNAME = 'www' %}
{% set UID = '888' %}
{% set GID = '888' %}
{% set PASSWORD = '$1$gEMONXHO$aBc0OVgDqCoyyK8ALmI160' %}
{% set USERNAME = 'www' %}

user-{{ USERNAME }}-add:
  group.present:
    - name: {{ GROUPNAME}}
    - gid: {{ GID }}
    - unless:
      - groups {{ GROUPNAME  }}

  user.present:
    - name: {{ USERNAME }}
    - groups:
      - {{ GROUPNAME  }}
    - uid: {{ UID  }}
    - gid: {{ GID  }}
    - gid_from_name: True
    - shell: /sbin/nologin
    - home: /home/{{ USERNAME  }}
    - createhome: False
    - password: {{ PASSWORD }}
    - require:
      - group: user-{{ USERNAME  }}-add 
    - unless:
      - id {{ USERNAME  }}
    
