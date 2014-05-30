# Agent Version
default['mon-agent']['agent_version'] = nil

# Boolean to enable debug_mode, which outputs massive amounts of log messages
# to the /tmp/ directory.
default['mon-agent']['debug'] = false

# Global dimensions, to be included in every metric.  Use comma-delimited
# name:value pairs, like "name1:value1, name2:value2"
default['mon-agent']['dimensions'] = nil

# How often you want the agent to collect data, in seconds. Any value between
# 15 and 60 is a reasonable interval.
default['mon-agent']['check_freq'] = 15

# Use mount points instead of volumes to track disk and fs metrics
default['mon-agent']['use_mount'] = false

# Change port the agent is listening to
default['mon-agent']['agent_port'] = 17123

# Monstatsd configuration
default['mon-agent']['monstatsd'] = false
default['mon-agent']['monstatsd_port'] = 8125
default['mon-agent']['monstatsd_interval'] = 30
default['mon-agent']['monstatsd_normalize'] = "yes"

# log-parsing configuration
default['mon-agent']['dogstreams'] = []

# Logging configuration
default['mon-agent']['disable_file_logging'] = false
default['mon-agent']['syslog']['active'] = false
default['mon-agent']['syslog']['udp'] = false
default['mon-agent']['syslog']['host'] = nil
default['mon-agent']['syslog']['port'] = nil

# daemon settings
default['mon_agent']['group'] = "root"
default['mon_agent']['owner'] = "mon-agent"
default['mon_agent']['data_bag'] = "mon_agent"
