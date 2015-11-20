require 'spec_helper'

describe service('sssd') do
  it { should be_enabled }
  it { should be_running }
end

describe package('sssd') do
  it { should be_installed }
end

if %w(debian ubuntu).include?(os[:family])
  if (os[:family] == 'ubuntu' && os[:release].to_i <= 12) || (os[:family] == 'debian' && os[:release].to_i <= 7)
    describe package('libsss-sudo0') do
      it { should be_installed }
    end
  else
    describe package('libsss-sudo') do
      it { should be_installed }
    end
  end
end
