include_recipe "#{cookbook_name}::software"

user node[:teamcity][:user] do
  home node[:teamcity][:user_home]
  shell '/bin/bash'
  supports manage_home: true
end

directory "#{node[:teamcity][:user_home]}/.ssh" do
  owner node[:teamcity][:user]
  group node[:teamcity][:user]
  mode 0700
end

execute 'generate_ssh_key' do
  user node[:teamcity][:user]
  command "ssh-keygen -t rsa -q -f #{node[:teamcity][:user_home]}/.ssh/id_rsa -P \"\""
  creates "#{node[:teamcity][:user_home]}/.ssh/id_rsa"
end

[node[:teamcity][:install_path],
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

execute 'change_teamcity_owner' do
  command "chown -R #{node[:teamcity][:user]} #{node[:teamcity][:install_path]}"
  action :nothing
end

execute "extract_teamcity" do
  command "tar --owner=#{node[:teamcity][:user]} --strip-components=1 -zxvf #{node[:teamcity][:download_path]}/#{node[:teamcity][:file_name]}"
  cwd node[:teamcity][:install_path]
  creates "#{node[:teamcity][:install_path]}/conf"
  notifies :run, 'execute[change_teamcity_owner]'
end

link node[:teamcity][:path] do
  owner node[:teamcity][:user]
  group node[:teamcity][:user]
  to node[:teamcity][:install_path]
end
