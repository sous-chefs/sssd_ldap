# Limitations

## Package Availability

The cookbook installs SSSD from native operating system repositories. It does not manage third-party package repositories or source builds.

### APT (Debian/Ubuntu)

* Ubuntu 22.04 and 24.04 provide the `sssd`, `sssd-ldap`, and `libsss-sudo` packages from native repositories.
* Debian 11, 12, and 13 provide the `sssd`, `sssd-ldap`, and `libsss-sudo` packages from native repositories.
* Debian 10 and older, plus Ubuntu 20.04 and older, are not retained in the test matrix because they are outside standard security support as of May 2026.

### DNF/YUM (RHEL family)

* RHEL-compatible 8, 9, and 10 platforms provide SSSD packages from native repositories.
* Amazon Linux 2023 provides SSSD packages from native repositories.
* Amazon Linux 2 is not retained because the current Chef/Cinc workstation baseline requires newer GLIBC/libxcrypt than the Amazon Linux 2 container provides.
* CentOS Linux 7 and CentOS Stream 8 are excluded because they are EOL.

### Zypper (SUSE)

* openSUSE Leap 15.6 is EOL as of April 30, 2026.
* openSUSE Leap 16 is not included until the cookbook has explicit verification for its SSSD package and auth stack behavior.

## Architecture Limitations

Package availability follows the supported architectures published by each operating system repository. The cookbook does not impose additional architecture constraints.

## Source/Compiled Installation

Source installation is not supported. Use the operating system packages for SSSD.

## Known Issues

* RHEL-family platforms use `authselect` on modern releases and retain `authconfig` only for Amazon Linux 2 compatibility.
* This cookbook configures LDAP-backed SSSD only; it does not manage LDAP servers, certificates, or identity data.
