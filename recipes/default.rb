include_recipe "apt::default"

package 'openjdk-7-jre'
package 'openjdk-7-jdk'

file_name     = "TeamCity-#{node[:teamcity][:version]}.tar.gz"
download_url  = "http://download.jetbrains.com/teamcity/#{file_name}"
download_path = Chef::Config[:file_cache_path]

install_path = "#{node[:teamcity][:path]}-#{node[:teamcity][:version]}"

remote_file "#{download_path}/#{file_name}" do
  source download_url
  action :create_if_missing
  not_if { ::File.exists?(install_path) }
end

user node[:teamcity][:user] do
  home node[:teamcity][:path]
  shell '/bin/bash'
end

[install_path,
 node[:teamcity][:data_path],
 "#{node[:teamcity][:data_path]}/config",
 "#{node[:teamcity][:data_path]}/lib",
 "#{node[:teamcity][:data_path]}/lib/jdbc"].each do |directory|

  directory directory do
    owner node[:teamcity][:user]
    group node[:teamcity][:user]
    mode 0755
  end

end

execute "tar --strip-components=1 -zxvf #{download_path}/#{file_name}" do
  cwd install_path
  creates "#{install_path}/conf"
end

execute "change #{install_path} owner" do
  command "chown -R #{node[:teamcity][:user]} #{install_path}"
  only_if { Etc.getpwuid(File.stat("#{install_path}/conf").uid).name != node[:teamcity][:user] }
end

link node[:teamcity][:path] do
  owner node[:teamcity][:user]
  group node[:teamcity][:user]
  to install_path
end

include_recipe "#{cookbook_name}::server"
include_recipe "#{cookbook_name}::agent"
