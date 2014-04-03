name             "mon_agent"
maintainer       "HP_Cloud_Monitoring"
maintainer_email "hpcs-mon@hp.com"
description      "Installs/Configures mon-agent components"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0"

%w{
  ubuntu
}.each do |os|
  supports os
end

suggests         "python"

recipe "mon_api::default", "Default"
