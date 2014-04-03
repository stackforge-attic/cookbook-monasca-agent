#
# Cookbook Name:: mon_agent
# Recipe:: default
#

# Agent configuration
package 'jahmon-agent' do
  action :purge
end

package 'jahmon-agent' do
  action :install
end

cookbook_file '/usr/share/datadog/agent/datadog-cert.pem' do
  action :create
  owner node['jahmon_agent']['owner']
  group node['jahmon_agent']['group']
  mode '644'
  source 'datadog-cert.pem'
end

directory "/var/log/jahmon-agent" do
    recursive true
    owner node['jahmon_agent']['owner']
    group node['jahmon_agent']['group']
    mode 0777
    action :create
end

service 'jahmon-agent' do
  action :enable
  provider Chef::Provider::Service::Init::Debian
end

setting = data_bag_item(node[:jahmon_agent][:data_bag], 'jahmon_agent')

template "/etc/dd-agent/datadog.conf" do
  action :create
  owner node['jahmon_agent']['owner']
  group node['jahmon_agent']['group']
  mode '644'
  source "datadog.conf.erb"
  variables(
    :setting => setting
  )
  notifies :restart, "service[jahmon-agent]"
end

include_recipe 'jahmon_agent::plugin_cfg'

