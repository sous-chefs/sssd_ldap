name             'sssd_ldap'
maintainer       'Tim Smith'
maintainer_email 'tsmith84@gmail.com'
license          'Apache 2.0'
description      'Sets up SSSD for LDAP on Ubuntu and RHEL systems'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '3.1.0'

%w(redhat centos amazon scientific oracle ubuntu debian).each do |os|
  supports os
end
source_url 'https://github.com/tas50/chef-sssd_ldap' if respond_to?(:source_url)
issues_url 'https://github.com/tas50/chef-sssd_ldap/issues' if respond_to?(:issues_url)
