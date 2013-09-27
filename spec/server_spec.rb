require 'spec_helper'

describe 'chef-teamcity-server::server' do
  let(:chef_run) { ChefSpec::ChefRunner.new platform: 'ubuntu', version: '12.04' }
  let(:converge) { chef_run.converge described_recipe }

  before do
    chef_run.node.set[:postgresql][:password][:postgres] = 'whatever'
    chef_run.node.set[:postgresql][:password][:teamcity] = 'whatever'
  end

  it 'creates init script' do
    expect(converge).to create_file '/etc/init.d/teamcity-server'
    expect(converge).to create_file_with_content('init.server', '/usr/local/teamcity/bin/teamcity-server.sh start')
  end

end
  