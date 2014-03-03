name             "mon-agent"
maintainer       "HP Cloud Monitoring"
maintainer_email "hpcs-mon@hp.com"
description      "Installs/Configures mon-agent components"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0"

%w{
  amazon
  centos
  debian
  redhat
  scientific
  ubuntu
}.each do |os|
  supports os
end

depends          "apt" # We recommend '>= 2.1.0'. See CHANGELOG.md for details
depends          "chef_handler", "~> 1.1.0"
depends          "yum"
suggests         "python"

recipe "datadog::default", "Default"
recipe "datadog::dd-agent", "Installs the Datadog Agent"
recipe "datadog::dd-handler", "Installs a Chef handler for Datadog"
recipe "datadog::repository", "Installs the Datadog package repository"
recipe "datadog::dogstatsd-python", "Installs the Python dogstatsd package for custom metrics"
recipe "datadog::dogstatsd-ruby", "Installs the Ruby dogstatsd package for custom metrics"