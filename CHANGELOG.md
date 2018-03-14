# CHANGELOG for sssd_ldap

This file is used to list changes made in each version of sssd_ldap.

## 4.2.2 (2018-03-13)

- If nscd is installed when authconfig is run, it will prepend to /etc/sssd/sssd.conf so make sure we remove it before sssd is installed not after

## 4.2.1 (2017-11-06)

- Fix the URL in the issues_url and source_url metadata
- Add Chef 12 testing to Travis CI
- Remove broken shell_fallback functionality which resulted in log warnings

## 4.2.0 (2017-08-13)

- [GH-32] - Support for amazon platform family
- Remove Ubuntu 12.04 support and testing as 12.04 is EOL
- Convert integration tests from ServerSpec to InSpec
- Move the template out the default dir since we require Chef 12
- Switch to dokken images for Travis testing and add Debian 7 / Debian 9 testing

## 4.1.2 (2017-05-08)

- Update apache2 license string to be a SPDX standard string
- Replaced hard coded root group with ohai root_group attribute to fix FreeBSD

## 4.1.1 (2017-03-06)

- Allow the user to ensure that sensitive resource data is not logged by the chef-client. Default value: false.
- Test with Local Delivery instead of Rake

## 4.1.0 (2016-09-15)

- Remove chef 11 compat in the metadata
- Require Chef 12.1
- attributized filter_users and filter_groups configuration options; fixes #11

## 4.0.0 (2016-07-19)

- Transferred cookbook ownership to Chef
- Added chef_version metadata
- Updated the minimum supported Chef version to 12.0
- Switched linting to Cookstyle and added a Rakefile for simplified testing

## 3.1.0 (2016-04-27)

- Added back support for RHEL 5 by making sure not to enable the sudo service on RHEL < 6 as the package is too old
- Switched Test Kitchen testing in Travis CI to kitchen-dokken
- Added support for Ubuntu 15.10+ by removing the hardcoded Upstart service provider on Ubuntu 13.10 or later. Chef 12 can auto determine the provider to use
- Added testing on Fedora 23 / Debian 8 / Ubuntu 16.04 / CentOS 5 in Travis CI

## 3.0.1 (2015-12-24):

- Added 2 new attributes for enabling autofs and ssh support, both of which default to false
- nil values for config options are now skipped in the config to prevent bad configs from being written out
- Added test kitchen integration testing in Travis CI

## 3.0.0 (2015-10-22):

- BREAKING: All config file attributes have been moved into the `node['sssd_ldap']['sssd_conf']` hash. You can add any key value config items to this by just adding to the hash.
- Add test kitchen config. Example: `node['sssd_ldap']['sssd_conf']['something'] = true`
- Update Travis to run unit/lint testing via ChefDK instead of Gems and to run kitchen-docker for integration testing
- Use the standard Chef rubocop config
- Update development deps to the latest in the Gemfile
- Require at least Chef 11

## 2.0.0:

- BREAKING: Change default['sssd_ldap']['ldap_tls_cacertdir'] to default['sssd_ldap']['ldap_tls_cacert'] and use per platform value
- BREAKING: default['sssd_ldap']['ldap_sudo'] is a boolean value now not a string
- BREAKING: nsswitch.conf is no longer templated, but edited inline instead
- BREAKING: NSCD package is now removed instead of stopping the service
- Debian support added
- ldap_group_name added to sssd.confg via default['sssd_ldap']['ldap_group_name'] attribute
- source_url and issues_url added to the metadata
- sssd is always restarted after templating the config now
- Chefspec unit tests added
- Use standard chef .gitignore file
- Update rules in the .rubocop.yml file
- Have Travis test on Ruby 2.2 and remove 1.9 from testing
- Add a Berksfile
- Update Gemfile deps and break out into groups
- Add a license file
- Add cookbook version badge to the readme
- Additional files added to the chefignore file

## 1.0.2:

- Added support for min_id / max_id
- Added support for conditional sudoers
- Added attributes to the Readme
- Updated Rubocop to 0.27

## 1.0.0:

- Switch modes to be strings not ints
- Remove duplicate reference to the config template
- Add shell_fallback attribute
- Support Ubuntu 13.04 and later with Upstart
- Allow authenticating to servers that don't require binding

## 0.1.6:

- Supports Ubuntu

## 0.1.5:

- Added some more configurable attributes

## 0.1.0:

- Initial release of sssd_ldap
