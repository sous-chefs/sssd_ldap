# frozen_string_literal: true

require 'spec_helper'

describe 'sssd_ldap' do
  step_into :sssd_ldap

  context 'on Ubuntu 24.04' do
    platform 'ubuntu', '24.04'

    context 'with default properties' do
      recipe do
        sssd_ldap 'default'
      end

      it { is_expected.to remove_package('nscd') }
      it { is_expected.to install_package('sssd') }
      it { is_expected.not_to install_package('libsss-sudo') }
      it { is_expected.to create_template('/etc/sssd/sssd.conf').with(owner: 'root', group: 'root', mode: '0600', sensitive: true) }
      it { is_expected.to enable_service('sssd') }
      it { is_expected.to start_service('sssd') }

      it 'renders the default LDAP configuration' do
        expect(chef_run).to render_file('/etc/sssd/sssd.conf').with_content('ldap_uri = ldap://something.yourcompany.com')
      end
    end

    context 'with sudo integration enabled' do
      recipe do
        sssd_ldap 'default' do
          ldap_sudo true
          sssd_conf_sensitive false
        end
      end

      it { is_expected.to install_package('libsss-sudo') }
      it { is_expected.to render_file('/etc/sssd/sssd.conf').with_content('services = nss, pam, sudo') }
      it { is_expected.to create_template('/etc/sssd/sssd.conf').with(sensitive: false) }
    end
  end

  context 'on AlmaLinux 9' do
    platform 'almalinux', '9'

    recipe do
      sssd_ldap 'default' do
        ldap_sudo true
      end
    end

    it { is_expected.to install_package('authselect') }
    it 'declares authselect for notification' do
      expect(chef_run.execute('configure sssd auth').command).to eq('/usr/bin/authselect select sssd with-sudo --force')
      expect(chef_run.execute('configure sssd auth').action).to eq([:nothing])
    end
  end

  context 'on Debian 13' do
    platform 'debian', '13'

    recipe do
      sssd_ldap 'default'
    end

    it { is_expected.to create_template('/etc/sssd/sssd.conf').with(owner: 'root', group: 'root', mode: '0640') }
  end

  context 'on Fedora 32' do
    platform 'fedora', '32'

    recipe do
      sssd_ldap 'default'
    end

    it { is_expected.to create_template('/etc/sssd/sssd.conf').with(owner: 'root', group: 'sssd', mode: '0640') }
  end

  context 'on Amazon Linux 2023' do
    platform 'amazon', '2023'

    recipe do
      sssd_ldap 'default'
    end

    it { is_expected.to install_package('authselect') }
    it 'declares authselect for notification' do
      expect(chef_run.execute('configure sssd auth').command).to eq('/usr/bin/authselect select sssd --force')
      expect(chef_run.execute('configure sssd auth').action).to eq([:nothing])
    end
  end
end
