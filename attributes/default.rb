# Add tags as override attributes in your role
default['jahmon-agent']['tags'] = ""

# Datadog defaults
default['jahmon-agent']['send_to_datadog'] = "no"
default['jahmon-agent']['dd_url'] = "https://app.datadoghq.com"
default['jahmon-agent']['api_key'] = ""
default['jahmon-agent']['collect_ec2_tags'] = "no"

# Repository configuration
default['jahmon-agent']['installrepo'] = true
default['jahmon-agent']['aptrepo'] = "http://apt.datadoghq.com"
default['jahmon-agent']['yumrepo'] = "http://yum.datadoghq.com/rpm"

# Agent Version
default['jahmon-agent']['agent_version'] = nil

# Boolean to enable debug_mode, which outputs massive amounts of log messages
# to the /tmp/ directory.
default['jahmon-agent']['debug'] = false

# How often you want the agent to collect data, in seconds. Any value between
# 15 and 60 is a reasonable interval.
default['jahmon-agent']['check_freq'] = 15

# If running on ec2, if true, use the instance-id as the host identifier
# rather than the hostname for the agent or nodename for chef-handler.
default['jahmon-agent']['use_ec2_instance_id'] = false

# Use mount points instead of volumes to track disk and fs metrics
default['jahmon-agent']['use_mount'] = false

# Change port the agent is listening to
default['jahmon-agent']['agent_port'] = 17123

# Start a graphite listener on this port
# https://github.com/DataDog/dd-agent/wiki/Feeding-Datadog-with-Graphite
default['jahmon-agent']['graphite'] = false
default['jahmon-agent']['graphite_port'] = 17124

# log-parsing configuration
default['jahmon-agent']['dogstreams'] = []

# Logging configuration
default['jahmon-agent']['syslog']['active'] = false
default['jahmon-agent']['syslog']['udp'] = false
default['jahmon-agent']['syslog']['host'] = nil
default['jahmon-agent']['syslog']['port'] = nil

default['jahmon-agent']['mon_api_url'] = nil
default['jahmon-agent']['mon_api_project_id'] = nil
default['jahmon-agent']['mon_api_username'] = nil
default['jahmon-agent']['mon_api_password'] = nil
default['jahmon-agent']['use_keystone'] = nil
default['jahmon-agent']['keystone_url'] = nil
default['jahmon-agent']['aggregate_metrics'] = nil
node.default['jahmon_agent']['group'] = "root"
node.default['jahmon_agent']['owner'] = "jahmon-agent"
node.default['jahmon_agent']['data_bag'] = "jahmon_agent"
