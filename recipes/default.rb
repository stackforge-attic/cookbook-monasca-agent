include_recipe "python"

# Pre-reqs that when installed by os package avoid compilation by pip
%w[python-psutil python-pymongo python-yaml supervisor sysstat].each do |pkg_name|
  package pkg_name do
    action :install
  end
end

settings = data_bag_item(node[:mon_agent][:data_bag], 'mon_agent')
execute 'mon-setup' do
  action :nothing
  command "/usr/local/bin/mon-setup -u #{settings['username']} -p #{settings['password']} -s #{settings['service']} --keystone_url #{settings['keystone_url']} --project_name #{settings['project_name']} --mon_url #{settings['mon_api_url']}"
end

python_pip 'mon-agent' do
  action :upgrade
  notifies :run, "execute[mon-setup]"
end

include_recipe 'mon_agent::plugin_cfg'
