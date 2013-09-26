include_recipe 'monit::default'

monit_monitrc 'teamcity-server' do 
  variables pid_file: node[:teamcity][:server][:pid_file],
    host: node[:teamcity][:host],
    port: node[:teamcity][:port]
end

monit_monitrc 'teamcity-agent' do
  variables pid_file: node[:teamcity][:agent][:pid_file]
end
