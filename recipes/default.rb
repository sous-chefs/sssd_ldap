#
# Cookbook Name:: sssd_ldap
# Recipe:: default
#
# Copyright 2013, Limelight Networks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if platform_family?('rhel')
  package "sssd" do
    action :install
  end

  # authconfig allows cli based intelligent manipulation of the pam.d files
  package "authconfig" do
    action :install
  end

  service "sssd" do
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
  end

  # nscd caching will break sssd and is not necessary
  service "nscd" do
    supports :status => true, :restart => true, :reload => true
    action [ :disable, :stop ]
  end

  # Have authconfig enable SSSD in the pam files
  execute "authconfig" do
    command "authconfig --enablesssdauth --update"
    action :nothing
  end

  # Make sure sss is added for auth in nsswitch
  template "/etc/nsswitch.conf" do
    source "nsswitch.conf.erb"
    owner "root"
    group "root"
    mode 00644
  end

  template "/etc/sssd/sssd.conf" do
    source "sssd.conf.erb"
    owner "root"
    group "root"
    mode 00600
    notifies :run, "execute[authconfig]"
  end
end
