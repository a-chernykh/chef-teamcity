include_recipe 'monit::default'

monit_monitrc 'teamcity-server' do 
  variables pid_file: node[:teamcity][:server][:pid_file]
end

monit_monitrc 'teamcity-agent' do
  variables pid_file: node[:teamcity][:agent][:pid_file]
end
