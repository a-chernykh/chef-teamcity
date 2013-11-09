# teamcity cookbook
[![Build Status](https://travis-ci.org/AndreyChernyh/chef-teamcity.png)](https://travis-ci.org/AndreyChernyh/chef-teamcity)

Downloads, installs and configures [TeamCity](http://www.jetbrains.com/teamcity/). It also installs [PostgreSQL](https://github.com/opscode-cookbooks/postgresql) and uses it as the backend database for TeamCity.

# Platforms
* Debian
* Ubuntu

Tested on:

* Ubuntu 13.04

# Recipes
* ```teamcity::default``` - installs PostgreSQL, TeamCity server and agent
* ```teamcity::monit``` - installs monit and configures it to watch server and agent

# Usage
Add ```recipe[teamcity]``` to your runlist. Optionally add ```recipe[teamcity::monit]``` if you'd like TeamCity to be monitored by monit.

# Configuration
You should set at least ```node[:postgresql][:password][:postgres]``` and ```node[:postgresql][:password][:teamcity]``` to avoid unsafe defaults.

* ```node[:teamcity][:version]``` - TeamCity version which will be downloaded (default: 8.0.3)
* ```node[:teamcity][:host]``` - Server hostname (default: localhost)
* ```node[:teamcity][:port]``` - Server port (default: 8111)
* ```node[:teamcity][:user]``` - System username under which TeamCity will be running (default: teamcity)
* ```node[:teamcity][:path]``` - Installation path (default: /usr/local/teamcity)
* ```node[:teamcity][:data_path]``` - Data path (default: /var/teamcity)
* ```node[:teamcity][:agent][:name]``` - Agent's name (default: Default agent)
* ```node[:teamcity][:database][:name]``` - PostgreSQL database name (default: teamcity)
* ```node[:teamcity][:database][:username]``` - PostgreSQL username (default: teamcity)
* ```node[:postgresql][:password][:postgres]``` - PostgreSQL password for 'postgres' user
* ```node[:postgresql][:password][:teamcity]``` - PostgreSQL password for 'teamcity' user

# Testing

Run [test kitchen](https://github.com/opscode/test-kitchen) integration suite:

```bash
bundle exec kitchen test
```

# License & Author
Andrey Chernih [andrey.chernih@gmail.com](mailto:andrey.chernih@gmail.com)

[Apache 2.0](https://github.com/AndreyChernyh/chef-secure-server/blob/master/LICENSE)
