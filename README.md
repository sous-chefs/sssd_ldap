# sssd_ldap Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/sssd_ldap.svg)](https://supermarket.chef.io/cookbooks/sssd_ldap)
[![CI State](https://github.com/sous-chefs/sssd_ldap/workflows/ci/badge.svg)](https://github.com/sous-chefs/sssd_ldap/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

This cookbook installs SSSD and configures it for LDAP authentication. As part of the setup of SSSD it will also remove the NSCD package as NSCD is known to interfere with SSSD (<https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/usingnscd-sssd.html>).

## Requirements

### Platforms

- Redhat
- Centos
- Amazon
- Scientific
- Oracle
- Ubuntu
- Debian

### Chef

- Chef 13+

### Cookbooks

- none

## Attributes

Arbitrary key/value pairs may be added to the `['sssd_conf']` attribute object. These key/values will be expanded in the domain block of `sssd.conf`. This allows you to set any SSSD configuration value you want, not just ones provided by the attributes in this cookbook.

Attribute                                  | Value                                                                          | Comment
------------------------------------------ | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------
`['sssd_conf']['id_provider']`             | `'ldap'`                                                                       |
`['sssd_conf']['auth_provider']`           | `'ldap'`                                                                       |
`['sssd_conf']['chpass_provider']`         | `'ldap'`                                                                       |
`['sssd_conf']['sudo_provider']`           | `'ldap'`                                                                       |
`['sssd_conf']['enumerate']`               | `'true'`                                                                       |
`['sssd_conf']['cache_credentials']`       | `'false'`                                                                      |
`['sssd_conf']['ldap_schema']`             | `'rfc2307bis'`                                                                 |
`['sssd_conf']['ldap_uri']`                | `'ldap://something.yourcompany.com'`                                           |
`['sssd_conf']['ldap_search_base']`        | `'dc=yourcompany,dc=com'`                                                      |
`['sssd_conf']['ldap_user_search_base']`   | `'ou=People,dc=yourcompany,dc=com'`                                            |
`['sssd_conf']['ldap_user_object_class']`  | `'posixAccount'`                                                               |
`['sssd_conf']['ldap_user_name']`          | `'uid'`                                                                        |
`['sssd_conf']['override_homedir']`        | `nil`                                                                          |
`['sssd_conf']['ldap_group_search_base']`  | `'ou=Groups,dc=yourcompany,dc=com'`                                            |
`['sssd_conf']['ldap_group_object_class']` | `'posixGroup'`                                                                 |
`['sssd_conf']['ldap_id_use_start_tls']`   | `'true'`                                                                       |
`['sssd_conf']['ldap_tls_reqcert']`        | `'never'`                                                                      |
`['sssd_conf']['ldap_tls_cacert']`         | `'/etc/pki/tls/certs/ca-bundle.crt'` or `'/etc/ssl/certs/ca-certificates.crt'` | defaults for RHEL and others respectively
`['sssd_conf']['ldap_default_bind_dn']`    | `'cn=bindaccount,dc=yourcompany,dc=com'`                                       | if you have a domain that doesn't require binding set this attributes to nil
`['sssd_conf']['ldap_default_authtok']`    | `'bind_password'`                                                              | if you have a domain that doesn't require binding set this to nil
`['authconfig_params']`                    | `'--enablesssd --enablesssdauth --enablelocauthorize --update'`                |
`['sssd_conf']['access_provider']`         | `nil`                                                                          | Should be set to `'ldap'`
`['sssd_conf']['ldap_access_filter']`      | `nil`                                                                          | Can use simple LDAP filter such as `'uid=abc123'` or more expressive LDAP filters like `'(&(objectClass=employee)(department=ITSupport))'`
`['sssd_conf']['min_id']`                  | `'1'`                                                                          | default, used to ignore lower uid/gid's
`['sssd_conf']['max_id']`                  | `'0'`                                                                          | default, used to ignore higher uid/gid's
`['ldap_sudo']`                            | `false`                                                                        | Adds ldap enabled sudoers (true/false)
`['ldap_ssh']`                             | `false`                                                                        | Adds ldap enabled ssh keys (true/false)
`['ldap_autofs']`                          | `false`                                                                        | Adds ldap enabled autofs config (true/false)
`['uninstall_nscd']`                       | `true`                                                                         | Allows configuration to not uninstall nscd package if required

## Recipes

- default: Installs and configures sssd daemon

## CA Certificates

If you manage your own CA then the easiest way to inject the certificate for system-wide use is as follows:

### RHEL

```
cp ca.crt /etc/pki/ca-trust/source/anchors
update-ca-trust enable
update-ca-trust extract
```

### Debian

```
cp ca.crt /usr/local/share/ca-certificates
update-ca-certificates
```

## Maintainers

This cookbook is maintained by Chef's Community Cookbook Engineering team. Our goal is to improve cookbook quality and to aid the community in contributing to cookbooks. To learn more about our team, process, and design goals see our [team documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/COOKBOOK_TEAM.MD). To learn more about contributing to cookbooks like this see our [contributing documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/CONTRIBUTING.MD), or if you have general questions about this cookbook come chat with us in #cookbok-engineering on the [Chef Community Slack](http://community-slack.chef.io/)

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
