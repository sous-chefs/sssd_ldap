#
# Cookbook Name:: sssd_ldap
# Attribute:: default
#
# Copyright 2013, Limelight Networks, Inc.
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

default['sssd_ldap']['ldap_schema'] = "rfc2307bis"
default['sssd_ldap']['ldap_uri'] = "ldap://something.yourcompany.com"
default['sssd_ldap']['ldap_search_base'] = "dc=yourcompany,dc=com"
default['sssd_ldap']['ldap_user_search_base'] = "ou=People,dc=yourcompany,dc=com"
default['sssd_ldap']['ldap_group_search_base'] = "ou=Groups,dc=yourcompany,dc=com"
default['sssd_ldap']['enumerate'] = "true"
default['sssd_ldap']['cache_credentials'] = "false"
default['sssd_ldap']['ldap_tls_reqcert'] = "allow"
default['sssd_ldap']['ldap_tls_cacertdir'] = "/etc/pki/tls/certs"