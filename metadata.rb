name 'aide'
description 'Installs and configures AIDE HIDS'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
maintainer 'John Daniels'
maintainer_email 'john.daniels@itison.com'
license 'BSD-2-Clause'
version '0.3.0'

supports 'centos'
supports 'ubuntu'

depends 'cron'

recipe 'aide', 'Installs and configures AIDE HIDS'
issues_url 'https://github.com/itison/chef-aide/issues'
source_url 'https://github.com/itison/chef-aide'
chef_version '>= 12' if respond_to?(:chef_version)
