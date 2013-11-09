name             'teamcity-test'
maintainer       'Andrey Chernih'
maintainer_email 'andrey.chernih@gmail.com'
license          'Apache License, Version 2.0'
description      'Installs TeamCity server and agent'
version          '1.0.0'

recipe 'fast_integration', 'Copies fake teamcity.tar.gz and execute recipes default and monit'

%w(ubuntu debian).each { |os| supports os }
%w(teamcity).each { |cookbook| depends cookbook }
