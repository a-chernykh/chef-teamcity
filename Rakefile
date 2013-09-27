require 'rubygems'
require 'bundler'

require 'pathname'

require 'foodcritic'
FoodCritic::Rake::LintTask.new

Bundler.setup

require 'berkshelf'

FileUtils.rm_rf('vendor/cookbooks')
berksfile = Berkshelf::Berksfile.from_file('Berksfile')
berksfile.vendor('vendor/cookbooks')

task default: %i(foodcritic knife chefspec)

desc 'Validates cookbook with "knife cookbook" command'
task :knife do
  sh "bundle exec knife cookbook test teamcity -o vendor/cookbooks"
end

desc 'Executes chefspec specs'
task :chefspec do
  sh "bundle exec rspec"
end
