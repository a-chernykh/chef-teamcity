name             'teamcity'
maintainer       'Andrey Chernih'
maintainer_email 'andrey.chernih@gmail.com'
license          'Apache License, Version 2.0'
description      'Installs TeamCity server and agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.2'

recipe 'default', 'Installs and configures TeamCity server and agent'
recipe 'monit',   'Installs and configures monit to monitor TeamCity'

%w(ubuntu debian).each { |os| supports os }
%w(apt postgresql database monit).each { |cookbook| depends cookbook }
