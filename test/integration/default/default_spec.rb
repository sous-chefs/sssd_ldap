describe service('sssd') do
  it { should be_enabled }
  it { should be_running }
end

describe package('sssd') do
  it { should be_installed }
end

describe package('libsss-sudo') do
  it { should be_installed }
end
