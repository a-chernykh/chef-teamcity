include_recipe "apt::default"

package 'openjdk-7-jre'
package 'openjdk-7-jdk'

file_name     = "TeamCity-#{node[:teamcity][:version]}.tar.gz"
download_url  = "http://download.jetbrains.com/teamcity/#{file_name}"
download_path = Chef::Config[:file_cache_path]

remote_file "#{download_path}/#{file_name}" do
  source download_url
  action :create_if_missing
end

user node[:teamcity][:user] do
  home node[:teamcity][:path]
end

[ node[:teamcity][:path], 
  node[:teamcity][:data_path],
  "#{node[:teamcity][:data_path]}/config",
  "#{node[:teamcity][:data_path]}/lib",
  "#{node[:teamcity][:data_path]}/lib/jdbc" ].each do |directory|

  directory directory do
    owner node[:teamcity][:user]
    mode 0755
  end

end

execute "tar --strip-components=1 -zxvf #{download_path}/#{file_name}" do
  user node[:teamcity][:user]
  cwd node[:teamcity][:path]
  creates "#{node[:teamcity][:path]}/conf"
end

include_recipe "#{cookbook_name}::server"
include_recipe "#{cookbook_name}::agent"
