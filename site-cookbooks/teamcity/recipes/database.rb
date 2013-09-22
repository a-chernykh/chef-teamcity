include_recipe 'postgresql::server'
include_recipe 'database::postgresql'

database_connection = {
  :host     => '127.0.0.1',
  :username => 'postgres', 
  :password => node['postgresql']['password']['postgres']
}.freeze

postgresql_database_user node[:teamcity][:database][:username] do
  connection database_connection
  password node['postgresql']['password']['teamcity']
  action :create
end

postgresql_database node[:teamcity][:database][:name] do
  connection database_connection
  owner node[:teamcity][:database][:username]
  action :create
end
