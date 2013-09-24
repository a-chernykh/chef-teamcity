include_recipe 'postgresql::server'
include_recipe 'database::postgresql'

database_connection = {
  :host     => '127.0.0.1',
  :username => 'postgres', 
  :password => node[:postgresql][:password][:postgres]
}.freeze

postgresql_database_user node[:teamcity][:database][:username] do
  connection database_connection
  password node[:postgresql][:password][:teamcity]
  action :create
end

postgresql_database node[:teamcity][:database][:name] do
  connection database_connection
  owner node[:teamcity][:database][:username]
  action :create
end

remote_file "#{node[:teamcity][:data_path]}/lib/jdbc/postgresql-9.2-1003.jdbc4.jar" do
  source "http://jdbc.postgresql.org/download/postgresql-9.2-1003.jdbc4.jar"
  owner node[:teamcity][:database][:username]
  action :create_if_missing
end

template "database.properties" do
  path "#{node[:teamcity][:data_path]}/config/database.properties"
  owner node[:teamcity][:user]
  mode 0600
  notifies :restart, "service[teamcity-server]"
end
