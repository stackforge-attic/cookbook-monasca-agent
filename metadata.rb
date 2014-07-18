# encoding: UTF-8#
#
name 'monasca_agent'
maintainer 'HP_Cloud_Monitoring'
maintainer_email 'hpcs-mon@hp.com'
description 'Installs/Configures monasca-agent components'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'
depends 'python'
recipe 'mon_api::default', 'Default'
