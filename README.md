sssd_ldap Cookbook
==================
[![Build Status](https://travis-ci.org/tas50/chef-sssd_ldap.svg?branch=master)](https://travis-ci.org/tas50/chef-sssd_ldap)

This cookbook installs SSSD and configures it for LDAP authentication

Requirements
------------

### Platform:

* Redhat
* Centos
* Amazon
* Scientific
* Oracle
* Ubuntu (10.04 / 12.04 / 14.04)

Attributes
----------
| Attribute | Value | Comment |
| -------------  | -------------  | -------------  |
| `['sssd_conf']['id_provider']` | `'ldap'` | |
| `['sssd_conf']['auth_provider']` | `'ldap'` | |
| `['sssd_conf']['chpass_provider']` | `'ldap'` | |
| `['sssd_conf']['sudo_provider']` | `'ldap'` | | 
| `['sssd_conf']['enumerate']` | `'true'` | |
| `['sssd_conf']['cache_credentials']` | `'false'` | |
| `['sssd_conf']['ldap_schema']` | `'rfc2307bis'` | |
| `['sssd_conf']['ldap_uri']` | `'ldap://something.yourcompany.com'` | |
| `['sssd_conf']['ldap_search_base']` | `'dc=yourcompany,dc=com'` | |
| `['sssd_conf']['ldap_user_search_base']` | `'ou=People,dc=yourcompany,dc=com'` | |
| `['sssd_conf']['ldap_user_object_class']` | `'posixAccount'` | |
| `['sssd_conf']['ldap_user_name']` | `'uid'` | |
| `['sssd_conf']['override_homedir']` | `nil` | |
| `['sssd_conf']['shell_fallback']` | `'/bin/bash'` | |
| `['sssd_conf']['ldap_group_search_base']` | `'ou=Groups,dc=yourcompany,dc=com'` | |
| `['sssd_conf']['ldap_group_object_class']` | `'posixGroup'` | |
| `['sssd_conf']['ldap_id_use_start_tls']` | `'true'` | |
| `['sssd_conf']['ldap_tls_reqcert']` | `'never'` | |
| `['sssd_conf']['ldap_tls_cacert']` | `'/etc/pki/tls/certs/ca-bundle.crt'` or `'/etc/ssl/certs/ca-certificates.crt'` | defaults for RHEL and others respectively |
| `['sssd_conf']['ldap_default_bind_dn']` | `'cn=bindaccount,dc=yourcompany,dc=com'` | if you have a domain that doesn't require binding set this attributes to nil
| `['sssd_conf']['ldap_default_authtok']` | `'bind_password'` | if you have a domain that doesn't require binding set this to nil | 
| `['sssd_conf']['authconfig_params']` | `'--enablesssd --enablesssdauth --enablelocauthorize --update'` | |
| `['sssd_conf']['access_provider']` | `nil` | Should be set to `'ldap'` |
| `['sssd_conf']['ldap_access_filter']` | nil| Can use simple LDAP filter such as `'uid=abc123'` or more expressive LDAP filters like `'(&(objectClass=employee)(department=ITSupport))'` | 
| `['sssd_conf']['min_id']` | `'1'` | default, used to ignore lower uid/gid's | 
| `['sssd_conf']['max_id']` | `'0'` | default, used to ignore higher uid/gid's | 
| `['sssd_conf']['ldap_sudo']` | `false` | Adds ldap enabled sudoers (true/false) |


Recipes
-------

*default: Installs and configures sssd daemon

CA Certificates
---------------

If you manage your own CA then the easiest way to inject the certificate for system-wide use is as follows:

### RHEL

    cp ca.crt /etc/pki/ca-trust/source/anchors
    update-ca-trust enable
    update-ca-trust extract

### Debian

    cp ca.crt /usr/local/share/ca-certificates
    update-ca-certificates

License and Author
------------------

Author:: Tim Smith - (<tsmith84@gmail.com>)

Copyright:: 2013-2014, Limelights Networks, Inc

License:: Apache 2.0

