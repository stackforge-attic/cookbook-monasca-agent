cookbooks-mon-agent
===================

#Overview
This cookbook populates configuration files for the Monitoring Agent.

#Data Bags
For use with configuration, the mon_agent data bag contains parameters
for interfacing with the Monitoring API, Datadog HQ (optional), and
logging levels.

metric_name_map translates Datadog's internal metric names to names
consistent with Monitoring. It can also discard specified metrics if
they are not needed.

Example mappings:
    "cpuStolen_mapping" : "cpu_stolen_perc"
    "rrqm/s_mapping"    : "DISCARD"

The first example maps "cpuStolen" in Datadog's output to a metric
named "cpu_stolen_perc" on the Monitoring API side.
The second example discards the Datadog metric named "rrqm/s"


#Recipes
##default
The default recipe sets up the Monitoring Agent environment by installing
the package, setting up logging directory, and populating the main
configuration file, datadog.conf with the contents of data bag item
data_bag_item(node[:mon_agent][:data_bag], 'mon_agent')

##plugin_cfg
Datadog plugins are configured in /etc/dd-agent/conf.d as YAML files ending
in .yaml which are created by this recipe.  The Agent will walk through these
files when the Collector (agent.py) starts.  The name of the file must match
a Python plugin in /etc/dd-agent/checks.d or /usr/share/datadog/agent/checks.d

conf.d/ file:     process.yaml
checks.d/ file:   process.py
data bag item:    node.default[:mon_agent][:plugin][:process]

Datadog's .yaml files are comprised of two different sections, 'init_config'
containing global configuration parameters, and 'instances' containing one or
more stanza containing details about the particular check to run.  These are
defined in
    node.default[:mon_agent][:plugin][:process][:init_config]
and
    node.default[:mon_agent][:plugin][:process][:instances]
respectively.

#Attributes
##default
These are global attributes for use with the datadog.conf file and installation
settings.

##network
These attributes configure the network plugin.

##plugin_config_basenode
A basic set of plugins to run on every installed instance are configured here.

#Templates
##datadog.conf.erb
This is the primary configuration file for the Agent

##plugin_yaml.erb
This template provides the basis for plugin .yaml files.
