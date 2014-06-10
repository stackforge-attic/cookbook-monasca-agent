cookbooks-mon-agent
===================

# Overview
This cookbook installs and configures the [Monitoring Agent](https://github.com/hpcloud-mon/mon-agent)

# Data Bags
For use with configuration, the `mon_agent` data bag contains parameters
for interfacing with the Monitoring API, global dimensions (a set of 
comma-delimited name:value pairs to be included in the Agent metrics),
and logging levels.

## Example
    {
      "id": "mon_agent",
      "keystone_url": "http://192.168.10.4:5000/v2.0",
      "username": "joe_user",
      "password": "correcthorsebatterystaple",
      "mon_api_url": "http://192.168.10.4:8080/v2.0",
      "service": "mini-mon"
    }


# Recipes
## default
The default recipe sets up the Monitoring Agent and runs mon-setup to configure.

## plugin_cfg
mon-agent plugins are configured in `/etc/mon-agent/conf.d/` as YAML files ending
in .yaml which are created by this recipe.  The Agent will walk through these
files when the Collector (`/usr/local/bin/mon-collector`) starts.  The name of
the file must match a Python plugin in `/etc/mon-agent/checks.d/` or
`/usr/local/lib/python2.7/dist-packages/monagent/collector/checks_d/`

- `conf.d/` file:    `process.yaml`                                
- `checks_d/` file:  `process.py`                                  
- data bag item:     `node.default[:mon_agent][:plugin][:process]` 

The .yaml files are comprised of two different sections, `init_config`
containing global configuration parameters, and 'instances' containing one or
more stanzas containing details about the particular check to run.  These are
defined in
    `node.default[:mon_agent][:plugin][:process][:init_config]`
and
    `node.default[:mon_agent][:plugin][:process][:instances]`
respectively.

The `nagios_wrapper` is a special case in the `plugin_cfg` recipe in that
if the check is defined, the dependent package `nagios-plugins-basic` is 
installed to provide many standard Nagios plugins.

# Attributes
## default
These are global attributes for use with the agent.conf file and installation
settings.

With the case of dimensions, `default['mon-agent']['dimensions'] = nil` appends
to the list of dimensions, if any, specified in the `mon_agent` data bag.

## network
These attributes configure the network plugin.

## plugin_config_basenode
These attributes configure a basic set of plugins to be installed on every instance.
These are in addition to the Monitoring Agent's existing set of basic metrics, listed
on the [mon-agent wiki](https://github.com/hpcloud-mon/mon-agent/wiki/mon-agent-User-Guide#standard-set-of-dimensions)

# Templates
## agent.conf.erb
This is the primary configuration file for the Agent, in `/etc/mon-agent/agent.conf`

## plugin_yaml.erb
This template provides the basis for plugin .yaml configuration files.
