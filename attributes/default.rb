#
# Cookbook:: sssd_ldap
# Attributes:: default
#
# Copyright:: 2013-2017, Limelight Networks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['sssd_ldap']['sssd_conf_sensitive'] = false
default['sssd_ldap']['filter_users'] = %w(root named avahi haldaemon dbus radiusd news nscd)
default['sssd_ldap']['filter_groups'] = []
default['sssd_ldap']['sssd_conf']['id_provider'] = 'ldap'
default['sssd_ldap']['sssd_conf']['auth_provider'] = 'ldap'
default['sssd_ldap']['sssd_conf']['chpass_provider'] = 'ldap'
default['sssd_ldap']['sssd_conf']['sudo_provider'] = 'ldap'
default['sssd_ldap']['sssd_conf']['enumerate'] = 'true'
default['sssd_ldap']['sssd_conf']['cache_credentials'] = 'false'

default['sssd_ldap']['sssd_conf']['ldap_schema'] = 'rfc2307bis'
default['sssd_ldap']['sssd_conf']['ldap_uri'] = 'ldap://something.yourcompany.com'
default['sssd_ldap']['sssd_conf']['ldap_search_base'] = 'dc=yourcompany,dc=com'
default['sssd_ldap']['sssd_conf']['ldap_user_search_base'] = 'ou=People,dc=yourcompany,dc=com'
default['sssd_ldap']['sssd_conf']['ldap_user_object_class'] = 'posixAccount'
default['sssd_ldap']['sssd_conf']['ldap_user_name'] = 'uid'
default['sssd_ldap']['sssd_conf']['override_homedir'] = nil

default['sssd_ldap']['sssd_conf']['ldap_group_search_base'] = 'ou=Groups,dc=yourcompany,dc=com'
default['sssd_ldap']['sssd_conf']['ldap_group_object_class'] = 'posixGroup'
default['sssd_ldap']['sssd_conf']['ldap_group_name'] = 'cn'

default['sssd_ldap']['sssd_conf']['ldap_id_use_start_tls'] = 'true'
default['sssd_ldap']['sssd_conf']['ldap_tls_reqcert'] = 'never'
default['sssd_ldap']['sssd_conf']['ldap_tls_cacert'] = value_for_platform_family('rhel' => '/etc/pki/tls/certs/ca-bundle.crt', 'amazon' => '/etc/pki/tls/certs/ca-bundle.crt', 'default' => '/etc/ssl/certs/ca-certificates.crt')

# if you have a domain that doesn't require binding set these two attributes to nil
default['sssd_ldap']['sssd_conf']['ldap_default_bind_dn'] = 'cn=bindaccount,dc=yourcompany,dc=com'
default['sssd_ldap']['sssd_conf']['ldap_default_authtok'] = 'bind_password'

default['sssd_ldap']['authconfig_params'] = '--enablesssd --enablesssdauth --enablelocauthorize --update'

default['sssd_ldap']['sssd_conf']['access_provider'] = nil # Should be set to 'ldap'
default['sssd_ldap']['sssd_conf']['ldap_access_filter'] = nil # Can use simple LDAP filter such as 'uid=abc123' or more expressive LDAP filters like '(&(objectClass=employee)(department=ITSupport))'

default['sssd_ldap']['sssd_conf']['min_id'] = '1'
default['sssd_ldap']['sssd_conf']['max_id'] = '0'
default['sssd_ldap']['ldap_sudo'] = false
default['sssd_ldap']['ldap_autofs'] = false
default['sssd_ldap']['ldap_ssh'] = false
