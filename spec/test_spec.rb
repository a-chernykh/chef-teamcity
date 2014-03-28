require 'spec_helper'

describe 'teamcity::test' do
  let(:chef_run) { ChefSpec::Runner.new step_into: %w(teamcity_plugin) }
  let(:converge) { chef_run.converge described_recipe }

  it 'creates /var/teamcity/plugins' do
    expect(converge).to create_directory('/var/teamcity/plugins')
  end

  it 'downloads http://teamcity.jetbrains.com/guestAuth/repository/download/bt398/lastest.lastSuccessful/teamcity.github.zip' do
    expect(converge).to create_remote_file_if_missing('/var/teamcity/plugins/teamcity.github.zip')
  end

  it 'restarts teamcity-server' do
    res = converge.find_resource 'remote_file', '/var/teamcity/plugins/teamcity.github.zip'
    expect(res).to notify('service[teamcity-server]').to(:restart)
  end
end
