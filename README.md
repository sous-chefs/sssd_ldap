sssd_ldap Cookbook
==================
[![Build Status](https://travis-ci.org/tas50/chef-sssd_ldap.svg?branch=master)](https://travis-ci.org/tas50/chef-sssd_ldap)
[![Cookbook Version](https://img.shields.io/cookbook/v/sssd_ldap.svg)](https://supermarket.chef.io/cookbooks/sssd_ldap)

This cookbook installs SSSD and configures it for LDAP authentication.  As part of the setup of SSSD it will also remove the NSCD package as NSCD is known to interfere with SSSD (https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/usingnscd-sssd.html).

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
| ['id_provider'] | 'ldap' | |
| ['auth_provider'] | 'ldap' | |
| ['chpass_provider'] | 'ldap' | |
| ['sudo_provider'] | 'ldap' | |
| ['enumerate'] | 'true' | |
| ['cache_credentials'] | 'false' | |
| ['ldap_schema'] | 'rfc2307bis' | |
| ['ldap_uri'] | 'ldap://something.yourcompany.com' | |
| ['ldap_search_base'] | 'dc=yourcompany,dc=com' | |
| ['ldap_user_search_base'] | 'ou=People,dc=yourcompany,dc=com' | |
| ['ldap_user_object_class'] | 'posixAccount' | |
| ['ldap_user_name'] | 'uid' | |
| ['override_homedir'] | nil | |
| ['shell_fallback'] | '/bin/bash' | |
| ['ldap_group_search_base'] | 'ou=Groups,dc=yourcompany,dc=com' | |
| ['ldap_group_object_class'] | 'posixGroup' | |
| ['ldap_id_use_start_tls'] | 'true' | |
| ['ldap_tls_reqcert'] | 'never' | |
| ['ldap_tls_cacert'] | '/etc/pki/tls/certs/ca-bundle.crt' or '/etc/ssl/certs/ca-certificates.crt' | defaults for RHEL and others respectively |
| ['ldap_default_bind_dn'] | 'cn=bindaccount,dc=yourcompany,dc=com' | if you have a domain that doesn't require binding set this attributes to nil
| ['ldap_default_authtok'] | 'bind_password' | if you have a domain that doesn't require binding set this to nil |
| ['authconfig_params'] | '--enablesssd --enablesssdauth --enablelocauthorize --update' | |
| ['access_provider'] | nil | Should be set to 'ldap' |
| ['ldap_access_filter'] | nil| Can use simple LDAP filter such as 'uid=abc123' or more expressive LDAP filters like '(&(objectClass=employee)(department=ITSupport))' |
| ['min_id'] | '1' | default, used to ignore lower uid/gid's |
| ['max_id'] | '0' | default, used to ignore higher uid/gid's |
| ['ldap_sudo'] | false | Adds ldap enabled sudoers (true/false) |


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

