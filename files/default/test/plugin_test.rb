require File.expand_path('../spec_helper', __FILE__)

describe_recipe 'teamcity::test' do
  it 'puts teamcity.github.zip to /var/teamcity/plugins' do
    file('/var/teamcity/plugins/teamcity.github.zip').must_exist
  end
end
