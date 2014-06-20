name             'aem'
maintainer       'Sergio Leone'
maintainer_email 'sergio.leone@qvc.com'
license          'Apache 2.0'
description      'Installs/Configures Adobe Experience Manager'
long_description 'Installs/Configures Adobe Experience Manager'
version          '0.1.0'

%w(amazon centos redhat scientific ubuntu).each do |os|
supports os
end

%w(java).each do |cb|
depends cb
end