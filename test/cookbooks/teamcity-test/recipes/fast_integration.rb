# Upload eagerly downloaded file to speed up integration suite
file_name = "TeamCity-#{node[:teamcity][:version]}.tar.gz"
cookbook_file File.join(Chef::Config[:file_cache_path], file_name) do
  action :create_if_missing
end if File.exists?("#{run_context.cookbook_collection[cookbook_name].root_dir}/files/default/#{file_name}")

# Then run default set of recipes
include_recipe 'teamcity::default'
include_recipe 'teamcity::monit'
