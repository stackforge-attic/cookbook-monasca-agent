#### agent plugin checks for basenode

# Host alive check for api server

node.default[:mon_agent][:plugin][:host_alive][:init_config] = {
  :ssh_port => 22,
  :ssh_timeout => 0.5,
  :ping_timeout => 1
}

node.default[:mon_agent][:plugin][:host_alive][:instances][:api_with_ssh] = {
  :host_name => "192.168.10.4",
  :alive_test => "ssh"
}

# Process checks: Everyone should be running ssh/sshd and ntpd

node.default[:mon_agent][:plugin][:process][:init_config] = {
}

node.default[:mon_agent][:plugin][:process][:instances][:ssh] = {
  :name => "ssh",
  :search_string => ["ssh", "sshd"]
}
node.default[:mon_agent][:plugin][:process][:instances][:ntpd] = {
  :name => "ntpd",
  :search_string => ["/usr/sbin/ntpd"],
  :exact_match => "True"
}

# Service checks: For demo, everyone can check mon api

node.default[:mon_agent][:plugin][:http_check][:init_config] = {
}

node.default[:mon_agent][:plugin][:http_check][:instances][:monapi] = {
  :name => "mon_api",
  :url => "http://192.168.10.4:8080",
  :timeout => 10,
  :collect_response_time => "true",
  :match_pattern => '.*status.*CURRENT.*',
}
node.default[:mon_agent][:plugin][:http_check][:instances][:monapi_health] = {
  :name => "mon_api_health",
  :url => "http://192.168.10.4:8081/healthcheck",
  :timeout => 10,
  :include_content => "true",
  :collect_response_time => "true",
  :match_pattern => '.*"healthy":true.*"healthy":true.*"healthy":true.*',
}

# mon_nagios_wrapper checks: For demo, everyone can check disk
#
#node.default[:mon_agent][:plugin][:nagios_wrapper][:init_config] = {
#  :check_path => "/usr/lib/nagios/plugins:/usr/local/bin/nagios"
#}
#
#node.default[:mon_agent][:plugin][:nagios_wrapper][:instances][:check_disk] = {
#  :service_name => "disk",
#  :check_command => "check_disk -w 15\\% -c 5\\% -A -i /srv/node",
#  :check_interval => 300
#}
