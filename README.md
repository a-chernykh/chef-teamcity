# Description
Downloads, installs and configures TeamCity server and build agent. It also installs PostgreSQL and uses it as the backend database for TeamCity.

# Platforms
* Debian
* Ubuntu

Tested on:

* Ubuntu 13.04

# Recipes

* ```teamcity::default``` - installs PostgreSQL, TeamCity server and agent
* ```teamcity::monit``` - installs monit and configures it to watch server and agent

# Configuration

Available config items:

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
