# Add tags as override attributes in your role
default['mon-agent']['tags'] = ""

# Agent Version
default['mon-agent']['agent_version'] = nil

# Boolean to enable debug_mode, which outputs massive amounts of log messages
# to the /tmp/ directory.
default['mon-agent']['debug'] = false

# How often you want the agent to collect data, in seconds. Any value between
# 15 and 60 is a reasonable interval.
default['mon-agent']['check_freq'] = 15

# Use mount points instead of volumes to track disk and fs metrics
default['mon-agent']['use_mount'] = false

# Change port the agent is listening to
default['mon-agent']['agent_port'] = 17123

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

#Api settings
default['mon-agent']['Api']['url'] = nil
default['mon-agent']['Api']['project_id'] = nil
default['mon-agent']['Api']['username'] = nil
default['mon-agent']['Api']['password'] = nil
default['mon-agent']['use_keystone'] = nil
default['mon-agent']['keystone_url'] = nil
default['mon-agent']['aggregate_metrics'] = nil
default['mon-agent']['dimensions'] = nil
default['mon-agent']['mapping_file'] = "/etc/dd-agent/mapping.json"
default['mon-agent']['custom_emitters'] = ""

# daemon settings
default['mon_agent']['group'] = "root"
default['mon_agent']['owner'] = "mon-agent"
default['mon_agent']['data_bag'] = "mon_agent"
