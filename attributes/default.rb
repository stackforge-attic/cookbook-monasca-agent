# Add tags as override attributes in your role
default['mon-agent']['tags'] = ""

# Datadog defaults
default['mon-agent']['use_dd'] = "no"
default['mon-agent']['dd_url'] = "https://app.datadoghq.com"
default['mon-agent']['api_key'] = "f218f9096f5a09929f65718d50a817fa"
default['mon-agent']['collect_ec2_tags'] = "no"

# Repository configuration
default['mon-agent']['installrepo'] = true
default['mon-agent']['aptrepo'] = "http://apt.datadoghq.com"
default['mon-agent']['yumrepo'] = "http://yum.datadoghq.com/rpm"

# Agent Version
default['mon-agent']['agent_version'] = nil

# Boolean to enable debug_mode, which outputs massive amounts of log messages
# to the /tmp/ directory.
default['mon-agent']['debug'] = false

# How often you want the agent to collect data, in seconds. Any value between
# 15 and 60 is a reasonable interval.
default['mon-agent']['check_freq'] = 15

# If running on ec2, if true, use the instance-id as the host identifier
# rather than the hostname for the agent or nodename for chef-handler.
default['mon-agent']['use_ec2_instance_id'] = false

# Use mount points instead of volumes to track disk and fs metrics
default['mon-agent']['use_mount'] = false

# Change port the agent is listening to
default['mon-agent']['agent_port'] = 17123

# Start a graphite listener on this port
# https://github.com/DataDog/dd-agent/wiki/Feeding-Datadog-with-Graphite
default['mon-agent']['graphite'] = false
default['mon-agent']['graphite_port'] = 17124

# Dogstatsd configuration
default['mon-agent']['dogstatsd'] = false
default['mon-agent']['dogstatsd_port'] = 8125
default['mon-agent']['dogstatsd_interval'] = 30
default['mon-agent']['dogstatsd_normalize'] = "yes"

# log-parsing configuration
default['mon-agent']['dogstreams'] = []

# Logging configuration
default['mon-agent']['disable_file_logging'] = false
default['mon-agent']['syslog']['active'] = false
default['mon-agent']['syslog']['udp'] = false
default['mon-agent']['syslog']['host'] = nil
default['mon-agent']['syslog']['port'] = nil

default['mon-agent']['use_pup'] = "yes"
default['mon-agent']['pup_port'] = 17125
default['mon-agent']['pup_interface'] = "localhost"
default['mon-agent']['pup_url'] = "http://localhost:17125"

default['mon-agent']['mon_api_url'] = nil
default['mon-agent']['mon_api_project_id'] = nil
default['mon-agent']['mon_api_username'] = nil
default['mon-agent']['mon_api_password'] = nil
default['mon-agent']['use_keystone'] = nil
default['mon-agent']['keystone_url'] = nil
default['mon-agent']['aggregate_metrics'] = nil
default['mon-agent']['mon_mapping_file'] = "/etc/dd-agent/mon_mapping.json"
default['mon-agent']['custom_emitters'] = "mon_lib/mon_api_emitter:MonApiEmitter"
node.default['mon_agent']['group'] = "root"
node.default['mon_agent']['owner'] = "mon-agent"
node.default['mon_agent']['data_bag'] = "mon_agent"
