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
package 'nagios-plugins' do
  action :install
  only_if node[:mon_agent][:plugin].has_key?(:nagios_wrapper)
end

# Make sure the datadog conf.d directory exists
directory "/etc/dd-agent/conf.d" do
  recursive true
  action :create
  owner node['mon_agent']['owner']
  group node['mon_agent']['group']
  mode 0755
end

# Configures the plugin yaml files based on node[:mon_agent][:plugin]
# attributes
node[:mon_agent][:plugin].each_key do |plugin|
  template "/etc/dd-agent/conf.d/#{plugin}.yaml" do
    source "plugin_yaml.erb"
    action :create
    owner node['mon_agent']['owner']
    group node['mon_agent']['group']
    mode 0644
    variables(
      :init_config => node[:mon_agent][:plugin][plugin][:init_config],
      :instances => node[:mon_agent][:plugin][plugin][:instances]
    )
    notifies :restart, "service[mon-agent]"
  end
end
