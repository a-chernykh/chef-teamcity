require File.expand_path('../spec_helper', __FILE__)

describe_recipe 'teamcity::monit' do
  it 'adds monit config for teamcity-server' do
    file('/etc/monit/conf.d/teamcity-server.monitrc').must_include 'pidfile /usr/local/teamcity/logs/catalina.pid'
  end

  it 'adds monit config for teamcity-agent' do
    file('/etc/monit/conf.d/teamcity-agent.monitrc').must_include 'pidfile /usr/local/teamcity/buildAgent/logs/buildAgent.pid'
  end
end
