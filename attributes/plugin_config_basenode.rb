#### agent plugin checks for basenode

# Host alive check for api server

node.default[:agent][:host_alive][:init_config] = {
  :ssh_port => 22,
  :ssh_timeout => 0.5,
  :ping_timeout => 1
}

node.default[:agent][:host_alive][:instances] = [
  {
    :host_name => "192.168.10.4",
    :alive_test => "ssh"
  }
]

# Process checks: Everyone should be running ssh/sshd and ntpd

node.default[:agent][:process][:init_config] = {
}

node.default[:agent][:process][:instances] = [
  {
    :name => "ssh",
    :search_string => ["ssh", "sshd"]
  },
  {
    :name => "ntpd",
    :search_string => ["/usr/sbin/ntpd"],
    :exact_match => "True"
  }
]

# Service checks: For demo, everyone can check jahmon api

node.default[:agent][:jahmon_http_check][:init_config] = {
}

node.default[:agent][:jahmon_http_check][:instances] = [
  {
    :name => "mon_api",
    :url => "https://192.168.10.4:8080",
    :timeout => 10,
    :collect_response_time => "true",
    :match_pattern => '.*unauthorized.*',
    :tags => ['mini-mon']
  },
  {
    :name => "mon_api_health",
    :url => "http://192.168.10.4:8081/healthcheck",
    :timeout => 10,
    :include_content => "true",
    :collect_response_time => "true",
    :match_pattern => '.*"healthy":true.*"healthy":true.*"healthy":true.*',
    :tags => ['mini-mon']
  }
]

# nagios_wrapper checks: For demo, everyone can check disk

node.default[:agent][:nagios_wrapper][:init_config] = {
  :check_path => "/usr/lib/nagios/plugins:/usr/local/bin/nagios"
}

node.default[:agent][:nagios_wrapper][:instances] = [
  {
    :service_name => "disk",
    :check_command => "check_disk -w 15\\% -c 5\\% -A -i /srv/node",
    :check_interval => 300
  }
]

