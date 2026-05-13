# frozen_string_literal: true

control 'sssd-ldap-service-01' do
  impact 1.0
  title 'SSSD is installed and running'

  describe package('sssd') do
    it { should be_installed }
  end

  describe service('sssd') do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'sssd-ldap-config-01' do
  impact 1.0
  title 'SSSD LDAP configuration is rendered'

  expected_mode = if os[:family] == 'fedora' || (os.name == 'debian' && os[:release].to_i >= 13)
                    '0640'
                  else
                    '0600'
                  end

  describe file('/etc/sssd/sssd.conf') do
    it { should exist }
    its('mode') { should cmp expected_mode }
    its('owner') { should eq 'root' }
    its('content') { should match(/^services = nss, pam, sudo$/) }
    its('content') { should match(%r{^ldap_uri = ldap://something\.yourcompany\.com$}) }
  end
end

control 'sssd-ldap-sudo-01' do
  impact 0.8
  title 'Debian family sudo support package is installed'

  only_if('libsss-sudo package is Debian family only') do
    %w(debian ubuntu).include?(os[:family])
  end

  describe package('libsss-sudo') do
    it { should be_installed }
  end
end
