{% set USERNAME = 'www' %}
{% set GROUPNAME = 'www' %}
{% set UID = '1000' %}
{% set GID = '1000' %}
#the password is used by "openssl passwd -1" 
#password is 1pLUZlG7JNEi#!rm
{% set PASSWORD = '$1$mpp2ypaV$GOV2mtbxxmbseeEaGWgCN.' %}
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
#    - password: {{ PASSWORD }}
    - require:
      - group: user-{{ USERNAME  }}-add 
    - unless:
      - id {{ USERNAME  }}
    
