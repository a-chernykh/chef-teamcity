service "teamcity-agent" do
  supports start: true, stop: true, restart: true
  action :nothing
end

template "init.agent" do
  path "/etc/init.d/teamcity-agent"
  mode 0755
  variables path: node[:teamcity][:agent][:path],
            user: node[:teamcity][:user]
  notifies :enable, "service[teamcity-agent]"
end

template "buildAgent.properties" do
  path "#{node[:teamcity][:agent][:path]}/conf/buildAgent.properties"
  variables url: node[:teamcity][:url],
           name: node[:teamcity][:agent][:name]
  notifies :restart, "service[teamcity-agent]"
end
