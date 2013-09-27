require 'spec_helper'

describe 'chef-teamcity-server::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new platform: 'ubuntu', version: '12.04' }
  let(:converge) { chef_run.converge described_recipe }

  before do
    chef_run.node.set[:postgresql][:password][:postgres] = 'whatever'
    chef_run.node.set[:postgresql][:password][:teamcity] = 'whatever'
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
