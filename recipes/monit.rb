include_recipe 'monit::default'

monitrc 'teamcity-server' do 
  template_cookbook cookbook_name
  template_source 'teamcity-server.monit.conf.erb'
end

monitrc 'teamcity-agent' do
  template_cookbook cookbook_name
  template_source 'teamcity-agent.monit.conf.erb'
end
