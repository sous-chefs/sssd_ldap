name             'sssd_ldap'
maintainer       'Tim Smith - Limelights Networks, Inc'
maintainer_email 'tsmith@limelight.com'
license          'Apache 2.0'
description      'Installs/Configures LDAP on RHEL/Ubuntu using SSSD'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

%w( redhat centos amazon scientific oracle ubuntu ).each do |os|
  supports os
end
