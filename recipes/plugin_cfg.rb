# encoding: UTF-8#
#
# Cookbook Name:: monasca_agent
# Recipe:: plugin_cfg
#

# Load nagios-plugins package if it's needed
package 'nagios-plugins-basic' do
  action :install
  only_if { node[:monasca_agent][:plugin].key?(:nagios_wrapper) }
end

# Create the conf.d directory if it doesn't exist
directory '/etc/monasca/agent/conf.d' do
  owner node[:monasca_agent][:owner]
  group node[:monasca_agent][:group]
  recursive true
end

# Configures the plugin yaml files based on node[:monasca_agent][:plugin]
# attributes
node[:monasca_agent][:plugin].each_key do |plugin|
  unless node[:monasca_agent][:plugin][plugin].key?(:init_config)
    node.normal[:monasca_agent][:plugin][plugin][:init_config] = {}
  end
  template "/etc/monasca/agent/conf.d/#{plugin}.yaml" do
    source 'plugin_yaml.erb'
    action :create
    owner node[:monasca_agent][:owner]
    group node[:monasca_agent][:group]
    mode 0644
    variables(
      init_config: node[:monasca_agent][:plugin][plugin][:init_config],
      instances: node[:monasca_agent][:plugin][plugin][:instances]
    )
    notifies :run, 'execute[monasca-setup]'
  end
end
