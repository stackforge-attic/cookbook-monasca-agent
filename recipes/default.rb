#
# Cookbook Name:: mon_agent
# Recipe:: default
#

# Agent configuration
package 'mon-agent' do
  action :purge
end

package 'mon-agent' do
  action :install
end

cookbook_file '/usr/share/datadog/agent/datadog-cert.pem' do
  action :create
  owner node['mon_agent']['owner']
  group node['mon_agent']['group']
  mode '644'
  source 'datadog-cert.pem'
end

directory "/var/log/mon-agent" do
    recursive true
    owner node['mon_agent']['owner']
    group node['mon_agent']['group']
    mode 0777
    action :create
end

service 'mon-agent' do
  action :enable
  provider Chef::Provider::Service::Init::Debian
end

setting = data_bag_item(node[:mon_agent][:data_bag], 'mon_agent')

template "/etc/dd-agent/datadog.conf" do
  action :create
  owner node['mon_agent']['owner']
  group node['mon_agent']['group']
  mode '644'
  source "datadog.conf.erb"
  variables(
    :setting => setting
  )
  notifies :restart, "service[mon-agent]"
end

include_recipe 'mon_agent::plugin_cfg'

