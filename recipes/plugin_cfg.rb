#
# Cookbook Name:: mon_agent
# Recipe:: plugin_cfg
#

# Common configuration
service "mon-agent" do
  action :enable
  supports :restart => true
end

# Load nagios-plugins package if it's needed
if node[:agent].has_key?(:nagios_wrapper)
  ["nagios-plugins"].each do |pkg|
    package pkg do
      action :install
    end
  end
end

# Make sure the datadog conf.d directory exists
directory "/etc/dd-agent/conf.d" do
  recursive true
  action :create
  owner node['mon_agent']['owner']
  group node['mon_agent']['group']
  mode 0755
end

# Configures the plugin yaml files based on node[:agent] attributes
node[:agent].each_key do |plugin|
  template "/etc/dd-agent/conf.d/#{plugin}.yaml" do
    source "plugin_yaml.erb"
    action :create
    owner node['mon_agent']['owner']
    group node['mon_agent']['group']
    mode 0644
    variables(
      :init_config => node[:agent][plugin][:init_config],
      :instances => node[:agent][plugin][:instances]
    )
    notifies :restart, "service[mon-agent]"
  end
end
