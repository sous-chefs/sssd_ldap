# sssd_ldap Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/sssd_ldap.svg)](https://supermarket.chef.io/cookbooks/sssd_ldap)
[![CI State](https://github.com/sous-chefs/sssd_ldap/workflows/ci/badge.svg)](https://github.com/sous-chefs/sssd_ldap/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

This cookbook provides an `sssd_ldap` custom resource that installs SSSD and configures LDAP authentication. As part of the setup it can also remove the NSCD package as NSCD is known to interfere with SSSD (<https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/usingnscd-sssd.html>).

## Requirements

### Platforms

- AlmaLinux 8+
- Amazon Linux 2023+
- CentOS Stream 9+
- Debian 11+
- Fedora
- Oracle Linux 8+
- Red Hat Enterprise Linux 8+
- Rocky Linux 8+
- Ubuntu 22.04+

### Chef

- Chef 15.3+

### Cookbooks

- none

## Resources

Arbitrary key/value pairs may be added to the `sssd_conf` property hash. These key/values will be expanded in the domain block of `sssd.conf`. This allows you to set any SSSD configuration value you want, not just ones provided by the default property value.

- [sssd_ldap](documentation/sssd_ldap_sssd_ldap.md)

## Migration

Upgrading from older cookbook releases that used `sssd_ldap::default` and `node['sssd_ldap']` attributes is a breaking change. Replace recipe includes and node attributes with the `sssd_ldap` resource. See [migration.md](migration.md).

## CA Certificates

If you manage your own CA then the easiest way to inject the certificate for system-wide use is as follows:

### RHEL

```bash
cp ca.crt /etc/pki/ca-trust/source/anchors
update-ca-trust enable
update-ca-trust extract
```

### Debian

```bash
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
