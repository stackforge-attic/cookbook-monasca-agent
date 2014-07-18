# encoding: UTF-8#
#
include_recipe 'python'

# Pre-reqs that when installed by os package avoid compilation by pip
%w[python-pymongo python-yaml supervisor sysstat].each do |pkg_name|
  package pkg_name do
    action :install
  end
end

settings = data_bag_item(node[:monasca_agent][:data_bag], 'monasca_agent')
execute 'monasca-setup' do
  action :nothing
  command "/usr/local/bin/monasca-setup -u #{settings['username']} -p #{settings['password']} -s #{settings['service']} --keystone_url #{settings['keystone_url']} --project_name #{settings['project_name']} --monasca_url #{settings['monasca_api_url']}"
end

python_pip 'monasca-agent' do
  action :install
  notifies :run, 'execute[monasca-setup]'
end

include_recipe 'monasca_agent::plugin_cfg'
