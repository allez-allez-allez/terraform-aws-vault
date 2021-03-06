{% from "vault/map.jinja" import vault with context %}

vault_service_init_file_managed:
  file.managed:
    - name: {{ vault.service.path }}
    - source: {{ vault.service.source }}
    - template: jinja
    - defaults:
        dev_configs: {{ vault.dev_configs }}

vault_service_running:
  service.running:
    - name: vault
    - enable: True
    - reload: True

{%- if not vault.dev_mode %}
manage_selinux_mode:
  selinux.mode:
    - name: permissive
    - require_in:
      - service: vault_service_running
{%- endif %}
