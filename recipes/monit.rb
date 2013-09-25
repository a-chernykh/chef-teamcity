include_recipe 'monit::default'

monitrc 'teamcity-server' do 
  variables pid_file: node[:teamcity][:server][:pid_file]
  template_cookbook "teamcity"
  template_source 'teamcity-server.monit.conf.erb'
end

monitrc 'teamcity-agent' do
  variables pid_file: node[:teamcity][:agent][:pid_file]
  template_cookbook "teamcity"
  template_source 'teamcity-agent.monit.conf.erb'
end
