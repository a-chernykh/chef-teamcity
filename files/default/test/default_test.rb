require File.expand_path('../spec_helper', __FILE__)

describe_recipe 'teamcity::default' do
  it 'downloads TeamCity' do
    file('/usr/local/teamcity/bin/teamcity-server.sh').must_exist
  end

  it 'creates teamcity user' do
    user('teamcity').must_exist
  end

  it 'creates jdbc plugins directory' do
    directory('/var/teamcity/lib/jdbc').must_exist.with(:owner, 'teamcity')
  end

  describe 'server' do
    describe 'database' do
      it 'installs PostgreSQL' do
        node['postgresql']['server']['packages'].each do |package_name|
          package(package_name).must_be_installed
        end
      end

      it 'creates teamcity user' do
        cmd = shell_out %Q(psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='teamcity'"|grep -q 1),
                        user: 'postgres'
        cmd.exitstatus.must_equal 0
      end

      it 'creates teamcity database' do
        cmd = shell_out %Q(psql postgres -tAc "SELECT 1 FROM pg_database WHERE datname='teamcity'"|grep -q 1),
                        user: 'postgres'
        cmd.exitstatus.must_equal 0
      end

      it 'adds jdbc driver' do
        file('/var/teamcity/lib/jdbc/postgresql-9.2-1003.jdbc4.jar').must_exist
      end

      it 'creates database.properties' do
        file('/var/teamcity/config/database.properties').must_include 'jdbc:postgresql://127.0.0.1:5432/teamcity'
        file('/var/teamcity/config/database.properties').must_include 'connectionProperties.user=teamcity'
        file('/var/teamcity/config/database.properties').must_include 'connectionProperties.password=pass456'
      end
    end

    it 'enables teamcity-server' do
      service('teamcity-server').must_be_enabled
    end

    it 'starts teamcity-server' do
      service('teamcity-server').must_be_running
    end

    it 'creates server.xml' do
      file('/usr/local/teamcity/conf/server.xml').must_include %Q(Connector port="8111")
      file('/usr/local/teamcity/conf/server.xml').must_include %Q(Host name="localhost")
    end
  end

  describe 'agent' do
    it 'enables teamcity-agent' do
      service('teamcity-agent').must_be_enabled
    end

    it 'starts teamcity-agent' do
      service('teamcity-agent').must_be_running
    end

    it 'creates buildAgent.properties' do
      file('/usr/local/teamcity/buildAgent/conf/buildAgent.properties').must_include "serverUrl=http://localhost:8111/"
      file('/usr/local/teamcity/buildAgent/conf/buildAgent.properties').must_include "name=Default agent"
    end
  end
end
