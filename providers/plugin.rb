action :install do
  service "teamcity-server" do
    supports start: true, stop: true, restart: true
    action :nothing
  end

  plugins_dir = "#{node[:teamcity][:data_path]}/plugins"

  directory plugins_dir do
    owner node[:teamcity][:user]
  end

  path = "#{plugins_dir}/#{::File.basename(new_resource.url)}"

  unless ::File.exist?(path)
    remote_file path do
      source new_resource.url
      owner node[:teamcity][:user]
      action :create_if_missing
      notifies :restart, "service[teamcity-server]"
    end

    new_resource.updated_by_last_action(true)
  end
end
