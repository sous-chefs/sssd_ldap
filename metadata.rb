name             'sssd_ldap'
maintainer       'Tim Smith - Limelights Networks, Inc'
maintainer_email 'tsmith@llnw.com'
license          'Apache 2.0'
description      'Installs/Configures LDAP on RHEL using SSSD'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ redhat centos amazon scientific oracle }.each do |os|
  supports os
end