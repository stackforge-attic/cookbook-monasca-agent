include_recipe "python"

# Pre-reqs that when installed by os package avoid compilation by pip
%w[python-psutil python-pymongo python-yaml supervisor sysstat].each do |pkg_name|
  package pkg_name do
    action :install
  end
end

python_pip 'mon-agent' do
  action :upgrade
end

user node['mon_agent']['owner'] do
  action :create
  system true
  gid node['mon_agent']['group']
end

%w[/var/log/mon-agent /etc/mon-agent /etc/mon-agent/conf.d ].each do |dir_name|
  directory dir_name do
      recursive true
      owner node['mon_agent']['owner']
      group node['mon_agent']['group']
      mode 0755
      action :create
  end
end

link "/etc/mon-agent/supervisor.conf" do
  action :create
  to '/usr/local/share/mon/agent/supervisor.conf'
end

link "/etc/init.d/mon-agent" do
  action :create
  to '/usr/local/share/mon/agent/mon-agent.init'
end

# Make the init script executable
file '/usr/local/share/mon/agent/mon-agent.init' do
  action :create
  mode "0755"
end

setting = data_bag_item(node[:mon_agent][:data_bag], 'mon_agent')

template "/etc/mon-agent/agent.conf" do
  action :create
  owner node['mon_agent']['owner']
  group node['mon_agent']['group']
  mode '644'
  source "agent.conf.erb"
  variables(
    :setting => setting
  )
  notifies :restart, "service[mon-agent]"
end

include_recipe 'mon_agent::plugin_cfg'

service 'mon-agent' do
  action [ :enable, :start ]
  provider Chef::Provider::Service::Init::Debian
end

