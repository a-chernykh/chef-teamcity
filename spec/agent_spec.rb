require 'spec_helper'

describe 'teamcity::agent' do
  let(:chef_run) { ChefSpec::Runner.new }
  let(:converge) { chef_run.converge described_recipe }

  before do
    chef_run.node.set[:postgresql][:password][:postgres] = 'whatever'
    chef_run.node.set[:postgresql][:password][:teamcity] = 'whatever'
    stub_command("grep -P 'authorizationToken=\r' /usr/local/teamcity/buildAgent/conf/buildAgent.properties").and_return(true)
  end

  it 'creates init script' do
    expect(converge).to create_template('/etc/init.d/teamcity-agent').with(variables: {
      path: '/usr/local/teamcity/buildAgent',
      user: 'teamcity'
    })
  end
end
