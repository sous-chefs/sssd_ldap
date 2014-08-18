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
| ['sssd_ldap']['id_provider'] | 'ldap' | |
| ['sssd_ldap']['auth_provider'] | 'ldap' | |
| ['sssd_ldap']['chpass_provider'] | 'ldap' | |
| ['sssd_ldap']['sudo_provider'] | 'ldap' | | 
| ['sssd_ldap']['enumerate'] | 'true' | |
| ['sssd_ldap']['cache_credentials'] | 'false' | |
| ['sssd_ldap']['ldap_schema'] | 'rfc2307bis' | |
| ['sssd_ldap']['ldap_uri'] | 'ldap://something.yourcompany.com' | |
| ['sssd_ldap']['ldap_search_base'] | 'dc=yourcompany,dc=com' | |
| ['sssd_ldap']['ldap_user_search_base'] | 'ou=People,dc=yourcompany,dc=com' | |
| ['sssd_ldap']['ldap_user_object_class'] | 'posixAccount' | |
| ['sssd_ldap']['ldap_user_name'] | 'uid' | |
| ['sssd_ldap']['override_homedir'] | nil | |
| ['sssd_ldap']['shell_fallback'] | '/bin/bash' | |
| ['sssd_ldap']['ldap_group_search_base'] | 'ou=Groups,dc=yourcompany,dc=com' | |
| ['sssd_ldap']['ldap_group_object_class'] | 'posixGroup' | |
| ['sssd_ldap']['ldap_id_use_start_tls'] | 'true' | |
| ['sssd_ldap']['ldap_tls_reqcert'] | 'never' | |
| ['sssd_ldap']['ldap_tls_cacertdir'] | '/etc/pki/tls/certs' | |
| ['sssd_ldap']['ldap_default_bind_dn'] | 'cn=bindaccount,dc=yourcompany,dc=com' | if you have a domain that doesn't require binding set this attributes to nil
| ['sssd_ldap']['ldap_default_authtok'] | 'bind_password' | if you have a domain that doesn't require binding set this to nil | 
| ['sssd_ldap']['authconfig_params'] | '--enablesssd --enablesssdauth --enablelocauthorize --update' | |
| ['sssd_ldap']['access_provider'] | nil | Should be set to 'ldap' |
| ['sssd_ldap']['ldap_access_filter'] | nil| Can use simple LDAP filter such as 'uid=abc123' or more expressive LDAP filters like '(&(objectClass=employee)(department=ITSupport))' | 
| ['sssd_ldap']['min_id'] | '1' | default, used to ignore lower uid/gid's | 
| ['sssd_ldap']['max_id'] | '0' | default, used to ignore higher uid/gid's | 
| ['sssd_ldap']['ldap_sudo'] | 'false' | Adds ldap enabled sudoers (true/false) |


Recipes
-------

*default: Installs and configures sssd daemon

License and Author
------------------

Author:: Tim Smith - Limelights Networks, Inc (<tsmith@llnw.com>)

Copyright:: 2013-2014, Tim Smith - Limelights Networks, Inc

License:: Apache 2.0

