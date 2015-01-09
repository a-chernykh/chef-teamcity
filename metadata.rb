name             'teamcity'
maintainer       'Andrey Chernih'
maintainer_email 'andrey.chernih@gmail.com'
license          'Apache License, Version 2.0'
description      'Installs TeamCity server and agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.1'

recipe 'default', 'Installs and configures TeamCity server'

%w(ubuntu debian).each { |os| supports os }
%w(apt).each { |cookbook| depends cookbook }
