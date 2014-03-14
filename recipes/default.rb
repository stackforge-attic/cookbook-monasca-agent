#
# Cookbook Name:: mon_agent
# Recipe:: default
#

# Agent configuration
package 'mon-agent' do
  action :upgrade
end

# Make sure the log directory exists
directory "/var/log/mon-agent" do
  recursive true
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# Make sure the config directory exists
directory "/etc/dd-agent" do
  owner "root"
  group "root"
  mode 0755
end

# Make sure the conf.d directory exists
remote_directory "/etc/dd-agent/conf.d" do
  owner "root"
  group "root"
  mode 0755
  files_owner "root"
  files_group "root"
  files_mode 640
  action :create_if_missing
end

#creds = data_bag_item(node[:mon_agent][:data_bag], 'mon_credentials')
setting = data_bag_item(node[:mon_agent][:data_bag], 'mon_agent')

template "/etc/dd-agent/datadog.conf" do
  action :create
  owner 'root'
  group 'root'
  mode '640'
  source "datadog.conf.erb"
  variables(
#    :creds => creds,
    :setting => setting,
    :api_key => node['mon-agent']['api_key'],
    :dd_url => node['mon-agent']['url']
  )
  notifies :restart, "service[mon-agent]"
end

template "/etc/init/mon-agent.conf" do
  action :create
  owner 'root'
  group 'root'
  mode '640'
  source "mon-agent-init.conf.erb"
  variables(
    :setting => setting
  )
end

service 'mon-agent' do
  action :enable
  provider Chef::Provider::Service::Upstart
end
