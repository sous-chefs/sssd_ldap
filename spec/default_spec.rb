require 'spec_helper'

describe 'sssd_ldap::default ubuntu 12.04' do
  let(:runner) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '12.04') }
  let(:chef_run) { runner.converge('sssd_ldap::default') }

  it 'installs libsss-sudo0 if sudo_ldap attribute set' do
    chef_run.node.normal['sssd_ldap']['ldap_sudo'] = true
    chef_run.converge('sssd_ldap::default')
    expect(chef_run).to install_package 'libsss-sudo0'
  end
end

describe 'sssd_ldap::default ubuntu 14.04' do
  let(:runner) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') }
  let(:chef_run) { runner.converge('sssd_ldap::default') }

  it 'installs sssd' do
    expect(chef_run).to install_package 'sssd'
  end

  it 'removes nscd' do
    expect(chef_run).to remove_package 'nscd'
  end

  it 'does not install libsss-sudo by default' do
    install = chef_run.package('libsss-sudo')
    expect(install).to do_nothing
  end

  it 'installs libsss-sudo if ldap_sudo attribute set' do
    chef_run.node.normal['sssd_ldap']['ldap_sudo'] = true
    chef_run.converge('sssd_ldap::default')
    expect(chef_run).to install_package 'libsss-sudo'
  end

  it 'starts sssd' do
    expect(chef_run).to start_service 'sssd'
  end
end

describe 'sssd_ldap::default centos' do
  let(:runner) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.6') }
  let(:chef_run) { runner.converge('sssd_ldap::default') }

  it 'installs authconfig' do
    expect(chef_run).to install_package 'authconfig'
  end
end
