# encoding: UTF-8#
#
name 'monasca_agent'
maintainer 'monasca'
maintainer_email 'monasca@lists.launchpad.net'
description 'Installs/Configures monasca-agent components'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.3'
depends          'python'
recipe 'mon_api::default', 'Default'
