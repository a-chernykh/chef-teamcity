cache_type 'BasicFile'
cache_options(:path => "#{ENV['HOME']}/.chef/checksums")

cookbook_path ["vendor/cookbooks"]
node_path     "nodes"

knife[:berkshelf_path] = "cookbooks"
