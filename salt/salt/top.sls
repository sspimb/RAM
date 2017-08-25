dev:
  'simonldap2*':
    - ansible.ansible
prod:
  'simon-min*':
    - openldap.extras
    - openldap.main
  'simon-tst*':
    - openldap.main
  't2*':
    - ram_initial.main
