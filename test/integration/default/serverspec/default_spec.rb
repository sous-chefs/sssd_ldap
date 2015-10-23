require 'serverspec'

set :backend, :exec

describe service('sssd') do
  it { should be_enabled }
  it { should be_running }
end

describe package('sssd') do
  it { should be_installed }
end

if ['debian', 'ubuntu'].include?(os[:family])
  describe package('libsss-sudo') do
    it { should be_installed }
  end
end
