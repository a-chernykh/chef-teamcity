default[:teamcity][:agent][:path]      = "#{node[:teamcity][:path]}/buildAgent"
default[:teamcity][:agent][:pid_file]  = "#{node[:teamcity][:agent][:path]}/logs/buildAgent.pid"
default[:teamcity][:agent][:name]      = "Default agent"
