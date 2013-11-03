require 'spec_helper'

describe 'teamcity::server' do
  let(:chef_run) { ChefSpec::Runner.new }
  let(:converge) { chef_run.converge described_recipe }

  before do
    chef_run.node.set[:postgresql][:password][:postgres] = 'whatever'
    chef_run.node.set[:postgresql][:password][:teamcity] = 'whatever'
  end

  it 'creates init script' do
    expect(converge).to create_template('/etc/init.d/teamcity-server').with(variables: {
      data_path: '/var/teamcity',
      pid_file: '/usr/local/teamcity/logs/catalina.pid',
      path: '/usr/local/teamcity',
      user: 'teamcity'
    })
  end
end
