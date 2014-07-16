# encoding: UTF-8#
#
name             'mon_agent'
maintainer       'HP_Cloud_Monitoring'
maintainer_email 'hpcs-mon@hp.com'
description      'Installs/Configures mon-agent components'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.1'
depends          'python'
recipe 'mon_api::default', 'Default'
