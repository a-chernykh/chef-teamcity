require 'spec_helper'

describe 'teamcity::default' do
  let(:chef_run) { ChefSpec::Runner.new }
  let(:converge) { chef_run.converge described_recipe }

  before do
    chef_run.node.set[:postgresql][:password][:postgres] = 'whatever'
    chef_run.node.set[:postgresql][:password][:teamcity] = 'whatever'
    stub_command("grep -P 'authorizationToken=\r' /usr/local/teamcity/buildAgent/conf/buildAgent.properties").and_return(true)
  end

  ['apt::default', "teamcity::server", "teamcity::agent"].each do |recipe|
    it "includes #{recipe} recipe" do
      expect(converge).to include_recipe recipe
    end
  end

  it 'downloads TeamCity' do
    expect(converge).to create_remote_file_if_missing("#{Chef::Config[:file_cache_path]}/TeamCity-8.0.3.tar.gz")
  end

  it 'create teamcity user' do
    expect(converge).to create_user('teamcity')
  end

  it 'create jdbc libs dir' do
    expect(converge).to create_directory('/var/teamcity/lib/jdbc')
  end
end
