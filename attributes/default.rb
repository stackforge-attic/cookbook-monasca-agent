# Place your API Key here, or set it on the role/environment/node
# The Datadog api key to associate your agent's data with your organization.
# Can be found here:
# https://app.datadoghq.com/account/settings
default['mon-agent']['api_key'] = nil

# Create an application key on the Account Settings page
default['mon-agent']['application_key'] = nil

# Don't change these
# The host of the Datadog intake server to send agent data to
default['mon-agent']['url'] = "https://app.datadoghq.com"

# Add tags as override attributes in your role
default['mon-agent']['tags'] = ""

# Repository configuration
default['mon-agent']['installrepo'] = true
default['mon-agent']['aptrepo'] = "http://apt.datadoghq.com"
default['mon-agent']['yumrepo'] = "http://yum.datadoghq.com/rpm"

# Agent Version
default['mon-agent']['agent_version'] = nil

# Set to true to always install datadog-agent-base (usually only installed on
# systems with a version of Python lower than 2.6) instead of datadog-agent
begin
  default['mon-agent']['install_base'] = Gem::Version.new(node['languages']['python']['version']) < Gem::Version.new('2.6.0')
rescue NoMethodError # nodes['languages']['python'] == nil
  Chef::Log.warn 'no version of python found'
end

# Chef handler version
default['mon-agent']['chef_handler_version'] = nil

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

# log-parsing configuration
default['mon-agent']['dogstreams'] = []

# Logging configuration
default['mon-agent']['syslog']['active'] = false
default['mon-agent']['syslog']['udp'] = false
default['mon-agent']['syslog']['host'] = nil
default['mon-agent']['syslog']['port'] = nil

# For service-specific configuration, use the integration recipes included
# in this cookbook, and apply them to the appropirate node's run list.
# The HP MaaS username, password and project ID
default['mon-agent']['mon_api_region'] = nil
default['mon-agent']['mon_api_project_id'] = nil
default['mon-agent']['mon_api_username'] = nil
default['mon-agent']['mon_api_password'] = nil
