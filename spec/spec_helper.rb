# encoding: UTF-8
require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! { add_filter 'monasca_agent' }

require 'chef/application'

LOG_LEVEL = :fatal
SUSE_OPTS = {
  platform: 'suse',
  version: '11.3',
  log_level: ::LOG_LEVEL
}
REDHAT_OPTS = {
  platform: 'redhat',
  version: '6.5',
  log_level: ::LOG_LEVEL
}
UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '12.04',
  log_level: ::LOG_LEVEL
}

shared_context 'monasca_stubs' do
  before do
    stub_data_bag_item('monasca_agent', 'monasca_agent').and_return(
    { 'keystone_url' => 'http://192.168.10.5:35357/v3',
      'username' => 'mini-mon',
      'password' => 'password',
      'project_name' => 'mini-mon',
      'monasca_api_url' => 'http://192.168.10.4:8080/v2.0',
      'service' => 'mini-mon'})
  end
end
