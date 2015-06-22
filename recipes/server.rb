include_recipe 'teamcity::default'

remote_file "#{node[:teamcity][:data_path]}/lib/jdbc/postgresql-9.3-1100.jdbc3.jar" do
  source "http://jdbc.postgresql.org/download/postgresql-9.3-1100.jdbc3.jar"
  owner node[:teamcity][:user]
  action :create_if_missing
end

template "database.properties" do
  path "#{node[:teamcity][:data_path]}/config/database.properties"
  owner node[:teamcity][:user]
  mode 0600
  variables name: node[:teamcity][:database][:name],
  host: node[:teamcity][:database][:host],
  username: node[:teamcity][:database][:username],
  password: node[:postgresql][:password][:teamcity]
  notifies :restart, "service[teamcity-server]"
end

template "init.server" do
  path "/etc/init.d/teamcity-server"
  mode 0755
  variables data_path: node[:teamcity][:data_path],
            pid_file: node[:teamcity][:server][:pid_file],
            heap_size: node[:teamcity][:server][:heap_size],
            max_perm_size: node[:teamcity][:server][:max_perm_size],
            path: node[:teamcity][:path],
            user: node[:teamcity][:user]
  notifies :start, "service[teamcity-server]"
end

template "server.xml" do
  path "#{node[:teamcity][:path]}/conf/server.xml"
  notifies :restart, "service[teamcity-server]"
end

service "teamcity-server" do
  supports start: true, stop: true, restart: true
  action :nothing
end
