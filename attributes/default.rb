default[:teamcity][:version]    = "8.1.1"
default[:teamcity][:host]       = "localhost"
default[:teamcity][:port]       = "8111"
default[:teamcity][:url]        = "http://#{node[:teamcity][:host]}:#{node[:teamcity][:port]}/"
default[:teamcity][:user]       = "teamcity"
default[:teamcity][:path]       = "/usr/local/teamcity"
default[:teamcity][:data_path]  = "/var/teamcity"
default[:teamcity][:user_home]  = "/home/#{node[:teamcity][:user]}"

default[:teamcity][:file_name]     = "TeamCity-#{node[:teamcity][:version]}.tar.gz"
default[:teamcity][:download_url]  = "http://download.jetbrains.com/teamcity/#{node[:teamcity][:file_name]}"
default[:teamcity][:download_path] = Chef::Config[:file_cache_path]
default[:teamcity][:install_path]  = "#{node[:teamcity][:path]}-#{node[:teamcity][:version]}"
