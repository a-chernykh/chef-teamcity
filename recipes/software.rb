include_recipe "apt::default"

package 'openjdk-7-jre'
package 'openjdk-7-jdk'

remote_file "#{node[:teamcity][:download_path]}/#{node[:teamcity][:file_name]}" do
  source node[:teamcity][:download_url]
  action :create_if_missing
  not_if { ::File.exists?(node[:teamcity][:install_path]) }
end
