site :opscode

metadata

cookbook 'apt', '~> 2.3.0'
cookbook 'postgresql'
cookbook 'database'
cookbook 'monit', git: 'https://github.com/phlipper/chef-monit.git'
cookbook 'postfix'

group :integration do
  cookbook 'minitest-handler'
end
