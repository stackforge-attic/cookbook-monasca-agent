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

# todo what is with the multiple levels and the repetition in the names in the data bag, fix
# todo service is a new setting in the databag
setting = data_bag_item(node[:mon_agent][:data_bag], 'mon_agent')
execute 'mon-setup' do
  action :run
  cmd "/usr/local/bin/mon-setup -u #{settings['username']} -p #{settings['password']} -s #{settings['service']} --keystone_url #{settings['keystone_url']} --project_name #{settings['project_name']} --mon_url #{settings['mon_api_url']}"
end

include_recipe 'mon_agent::plugin_cfg'
