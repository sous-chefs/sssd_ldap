# sssd_ldap

Installs SSSD and configures LDAP authentication.

## Actions

| Action | Description |
| ------ | ----------- |
| `:create` | Installs SSSD, renders `/etc/sssd/sssd.conf`, configures host authentication, and starts the service. |

## Properties

| Property              | Type        | Default                                                     | Description                                                       |
| --------------------- | ----------- | ----------------------------------------------------------- | ----------------------------------------------------------------- |
| `filter_users`        | Array       | `%w(root named avahi haldaemon dbus radiusd news nscd)`     | Users excluded from SSSD lookups.                                 |
| `filter_groups`       | Array       | `[]`                                                        | Groups excluded from SSSD lookups.                                |
| `sssd_conf`           | Hash        | platform-aware LDAP defaults                                | Key/value pairs rendered into the `[domain/LDAP]` section.        |
| `sssd_conf_sensitive` | true, false | `true`                                                      | Marks the rendered config as sensitive.                           |
| `authconfig_params`   | String      | legacy authconfig defaults                                  | Arguments for authconfig on legacy RHEL-family platforms.         |
| `ldap_sudo`           | true, false | `false`                                                     | Enables sudo integration through SSSD.                            |
| `ldap_autofs`         | true, false | `false`                                                     | Enables autofs integration through SSSD.                          |
| `ldap_ssh`            | true, false | `false`                                                     | Enables SSH key integration through SSSD.                         |
| `uninstall_nscd`      | true, false | `true`                                                      | Removes nscd before configuring SSSD.                             |
| `service_name`        | String      | `sssd`                                                      | SSSD service name.                                                |

## Examples

### Basic LDAP configuration

```ruby
sssd_ldap 'default' do
  sssd_conf(
    'ldap_uri' => 'ldaps://ldap.example.com',
    'ldap_search_base' => 'dc=example,dc=com',
    'ldap_user_search_base' => 'ou=People,dc=example,dc=com',
    'ldap_group_search_base' => 'ou=Groups,dc=example,dc=com',
    'ldap_default_bind_dn' => nil,
    'ldap_default_authtok' => nil
  )
end
```

### LDAP sudo integration

```ruby
sssd_ldap 'default' do
  ldap_sudo true
end
```

### Preserve nscd

```ruby
sssd_ldap 'default' do
  uninstall_nscd false
end
```
