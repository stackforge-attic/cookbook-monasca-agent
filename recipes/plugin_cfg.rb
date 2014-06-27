#
# Cookbook Name:: mon_agent
# Recipe:: plugin_cfg
#

# Load nagios-plugins package if it's needed
package 'nagios-plugins-basic' do
  action :install
  only_if { node[:mon_agent][:plugin].has_key?(:nagios_wrapper) }
end

# Configures the plugin yaml files based on node[:mon_agent][:plugin]
# attributes
node[:mon_agent][:plugin].each_key do |plugin|
  if not node[:mon_agent][:plugin][plugin].has_key?(:init_config)
    node[:mon_agent][:plugin][plugin][:init_config] = {}
  end
  template "/etc/mon-agent/conf.d/#{plugin}.yaml" do
    source "plugin_yaml.erb"
    action :create
    owner node['mon_agent']['owner']
    group node['mon_agent']['group']
    mode 0644
    variables(
      :init_config => node[:mon_agent][:plugin][plugin][:init_config],
      :instances => node[:mon_agent][:plugin][plugin][:instances]
    )
    notifies :run, "execute[mon-setup]"
  end
end
