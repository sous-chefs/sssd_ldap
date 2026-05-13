# frozen_string_literal: true

sssd_ldap 'default' do
  ldap_sudo true
  sssd_conf_sensitive false
end
