# add the packages

{% for val in pillar.get('ldap_p', {}) %}
{{val}}:
  pkg.installed:
    - pkg: {{val}}
{% endfor %}

# remove the users 

{% for user in pillar.get('userlist', {}) %}
{{user}}:
  user.absent:
    - name: {{user}}
{% endfor %}

copy ldap.conf:
   file.managed:
     - name: /etc/ldap/ldap.conf
     - source: salt://openldap/templates/ldap.conf
     - user: root
     - group: root
     - mode: 644
     - makedirs: true
     - backup: minion

# copy nsswitch.conf

copy the nsswitch conf:
   file.managed:
     - name: /etc/nsswitch.conf
     - source: salt://openldap/files/nsswitch.conf
     - user: root
     - group: root
     - mode: 644
     - backup: minion

# copy the templates


{% for file in ['libnss-ldap.conf', 'pam_ldap.conf'] %}
{{ file }}:
  file.managed:
     - name: /etc/{{ file }}
     - source: salt://openldap/templates/{{ file }}.template
     - user: root
     - group: root
     - mode: 644
     - backup: minion
     - template: jinja
{% endfor %}

# copy the pam files

{% for file in [ 'common-auth','common-password','common-session','common-account','common-session-noninteractive'] %}
{{ file }}:
  file.managed:
     - name: /etc/pam.d/{{ file }}
     - source: salt://openldap/files/{{ file }}
     - user: root
     - group: root
     - mode: 644
     - backup: minion
{% endfor %}

#set the user perms from ldap 

{% for usr in pillar.get('userlist', {}) %}
/home/{{usr}}:
  file.directory:
   - user: {{usr}}
   - group: {{usr}}
{% endfor %}
