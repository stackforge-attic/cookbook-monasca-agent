#
# Cookbook Name:: mon_agent
# Recipe:: default
#

# Agent configuration
package 'mon-agent' do
  action :upgrade
end

cookbook_file '/etc/init/mon-agent.conf' do
  action :create
  owner 'root'
  group node['mon_agent']['group']
  source 'mon-agent.conf'
end

cookbook_file '/usr/share/pyshared/monagent/datadog-cert.pem' do
  action :create
  owner node['mon_agent']['owner']
  group node['mon_agent']['group']
  source 'datadog-cert.pem'
end

service 'mon-agent' do
  action :enable
  provider Chef::Provider::Service::Upstart
end

#creds = data_bag_item(node[:mon_agent][:data_bag], 'mon_credentials')
setting = data_bag_item(node[:mon_agent][:data_bag], 'mon_agent')

# Make sure the log directory exists
directory "/var/log/mon-agent" do
  recursive true
  owner 'root'
  group node['mon_agent']['group']
  mode 0755
  action :create
end

# Make sure the config directory exists
directory "/etc/dd-agent" do
  owner 'root'
  group node['mon_agent']['group']
  mode 0755
end

# Make sure the conf.d directory exists
remote_directory "/etc/dd-agent/conf.d" do
  owner 'root'
  group node['mon_agent']['group']
  mode 0755
  files_owner 'root'
  files_group node['mon_agent']['group']
  files_mode 640
  action :create_if_missing
end

template "/etc/dd-agent/datadog.conf" do
  action :create
  owner 'root'
  group node['mon_agent']['group']
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
