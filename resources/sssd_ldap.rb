# frozen_string_literal: true

provides :sssd_ldap
unified_mode true

property :filter_users, Array,
         default: %w(root named avahi haldaemon dbus radiusd news nscd),
         description: 'Users excluded from SSSD lookups'
property :filter_groups, Array,
         default: [],
         description: 'Groups excluded from SSSD lookups'
property :sssd_conf, Hash,
         default: lazy {
           {
             'id_provider' => 'ldap',
             'auth_provider' => 'ldap',
             'chpass_provider' => 'ldap',
             'sudo_provider' => 'ldap',
             'enumerate' => 'true',
             'cache_credentials' => 'false',
             'ldap_schema' => 'rfc2307bis',
             'ldap_uri' => 'ldap://something.yourcompany.com',
             'ldap_search_base' => 'dc=yourcompany,dc=com',
             'ldap_user_search_base' => 'ou=People,dc=yourcompany,dc=com',
             'ldap_user_object_class' => 'posixAccount',
             'ldap_user_name' => 'uid',
             'override_homedir' => nil,
             'ldap_group_search_base' => 'ou=Groups,dc=yourcompany,dc=com',
             'ldap_group_object_class' => 'posixGroup',
             'ldap_group_name' => 'cn',
             'ldap_id_use_start_tls' => 'true',
             'ldap_tls_reqcert' => 'never',
             'ldap_tls_cacert' => platform_family?('rhel', 'amazon') ? '/etc/pki/tls/certs/ca-bundle.crt' : '/etc/ssl/certs/ca-certificates.crt',
             'ldap_default_bind_dn' => 'cn=bindaccount,dc=yourcompany,dc=com',
             'ldap_default_authtok' => 'bind_password',
             'access_provider' => nil,
             'ldap_access_filter' => nil,
             'min_id' => '1',
             'max_id' => '0',
           }
         },
         description: 'Key/value pairs rendered into the [domain/LDAP] section of sssd.conf'
property :sssd_conf_sensitive, [true, false],
         default: true,
         description: 'Whether the rendered sssd.conf template is sensitive'
property :authconfig_params, String,
         default: '--enablesssd --enablesssdauth --enablelocauthorize --update',
         description: 'Arguments passed to authconfig on legacy RHEL-family platforms'
property :ldap_sudo, [true, false],
         default: false,
         description: 'Enable sudo integration through SSSD'
property :ldap_autofs, [true, false],
         default: false,
         description: 'Enable autofs integration through SSSD'
property :ldap_ssh, [true, false],
         default: false,
         description: 'Enable SSH key integration through SSSD'
property :uninstall_nscd, [true, false],
         default: true,
         description: 'Remove nscd before configuring SSSD'
property :service_name, String,
         default: 'sssd',
         description: 'SSSD service name'

default_action :create

action :create do
  package 'nscd' do
    action :remove
    only_if { new_resource.uninstall_nscd }
  end

  package 'sssd'

  package 'sssd-ldap' do
    only_if { platform_family?('suse') }
  end

  package 'libsss-sudo' do
    only_if { platform_family?('debian') && new_resource.ldap_sudo }
  end

  if platform_family?('rhel', 'amazon')
    package auth_tool_package

    ruby_block 'nsswitch sudoers' do
      block do
        edit = Chef::Util::FileEdit.new('/etc/nsswitch.conf')
        edit.insert_line_if_no_match(/^sudoers:/, 'sudoers: files')

        if new_resource.ldap_sudo
          edit.search_file_replace(/^sudoers:([ \t]*(?!sss\b)\w+)*[ \t]*$/, '\0 sss')
        else
          edit.search_file_replace(/^(sudoers:.*)\bsss[ \t]*/, '\1')
        end

        edit.write_file
      end
      action :nothing
    end

    execute 'configure sssd auth' do
      command auth_tool_command
      notifies :run, 'ruby_block[nsswitch sudoers]', :immediately
      action :nothing
    end
  end

  template '/etc/sssd/sssd.conf' do
    source 'sssd.conf.erb'
    cookbook 'sssd_ldap'
    owner 'root'
    group sssd_conf_group
    mode sssd_conf_mode
    sensitive new_resource.sssd_conf_sensitive
    variables(
      filter_users: new_resource.filter_users,
      filter_groups: new_resource.filter_groups,
      ldap_autofs: new_resource.ldap_autofs,
      ldap_ssh: new_resource.ldap_ssh,
      ldap_sudo: new_resource.ldap_sudo,
      sssd_conf: new_resource.sssd_conf
    )
    notifies :run, 'execute[configure sssd auth]', :immediately if platform_family?('rhel', 'amazon')
    notifies :restart, "service[#{new_resource.service_name}]"
  end

  service new_resource.service_name do
    supports status: true, restart: true, reload: true
    action %i(enable start)
  end
end

action_class do
  def auth_tool_package
    legacy_authconfig? ? 'authconfig' : 'authselect'
  end

  def auth_tool_command
    if legacy_authconfig?
      "/usr/sbin/authconfig #{new_resource.authconfig_params}"
    else
      sudo_feature = new_resource.ldap_sudo ? ' with-sudo' : ''
      "/usr/bin/authselect select sssd#{sudo_feature} --force"
    end
  end

  def legacy_authconfig?
    platform?('amazon') && node['platform_version'].to_i < 2023
  end

  def sssd_conf_group
    platform?('fedora') ? 'sssd' : node['root_group']
  end

  def sssd_conf_mode
    platform?('fedora') || (platform?('debian') && node['platform_version'].to_i >= 13) ? '0640' : '0600'
  end
end
