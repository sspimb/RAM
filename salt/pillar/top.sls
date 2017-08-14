base:
 'simonlda*':
   - ansible.users
   - ansible.groups
   - ansible.ansible
   - ldapclients.dev
 'simon-min*':
   - ldapclients.prod
   - openldap.global
