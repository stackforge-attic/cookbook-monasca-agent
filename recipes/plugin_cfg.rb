#
# Cookbook Name:: jahmon_agent
# Recipe:: plugin_cfg
#

# Common configuration
service "jahmon-agent" do
  action :enable
  supports :restart => true
end

# Load nagios-plugins package if it's needed
if node[:jahmon_agent][:plugin].has_key?(:nagios_wrapper)
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
  owner node['jahmon_agent']['owner']
  group node['jahmon_agent']['group']
  mode 0755
end

# Configures the plugin yaml files based on node[:jahmon_agent][:plugin]
# attributes
node[:jahmon_agent][:plugin].each_key do |plugin|
  template "/etc/dd-agent/conf.d/#{plugin}.yaml" do
    source "plugin_yaml.erb"
    action :create
    owner node['jahmon_agent']['owner']
    group node['jahmon_agent']['group']
    mode 0644
    variables(
      :init_config => node[:jahmon_agent][:plugin][plugin][:init_config],
      :instances => node[:jahmon_agent][:plugin][plugin][:instances]
    )
    notifies :restart, "service[jahmon-agent]"
  end
end
