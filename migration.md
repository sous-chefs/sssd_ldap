# Migrating to Custom Resources

This release removes the legacy `sssd_ldap::default` recipe and the `node['sssd_ldap']` attribute API. Configure SSSD with the `sssd_ldap` custom resource instead.

## Before

```ruby
node.default['sssd_ldap']['ldap_sudo'] = true
node.default['sssd_ldap']['sssd_conf']['ldap_uri'] = 'ldaps://ldap.example.com'

include_recipe 'sssd_ldap::default'
```

## After

```ruby
sssd_ldap 'default' do
  ldap_sudo true
  sssd_conf(
    'ldap_uri' => 'ldaps://ldap.example.com',
    'ldap_search_base' => 'dc=example,dc=com',
    'ldap_user_search_base' => 'ou=People,dc=example,dc=com',
    'ldap_group_search_base' => 'ou=Groups,dc=example,dc=com'
  )
end
```

Any arbitrary SSSD domain setting previously added under `node['sssd_ldap']['sssd_conf']` should now be added to the `sssd_conf` property hash.
