require 'chefspec'

describe 'sssd_ldap::default' do
  let(:runner) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') }
  let(:chef_run) { runner.converge(described_recipe) }

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

  it 'starts sssd' do
    expect(chef_run).to start_service 'sssd'
  end
end

at_exit { ChefSpec::Coverage.report! }
