require 'rubygems'
require 'bundler'

require 'pathname'

require 'foodcritic'
FoodCritic::Rake::LintTask.new

Bundler.setup

task default: %i(foodcritic knife chefspec)

desc 'Validates cookbook with "knife cookbook" command'
task :knife do
  cookbook = File.expand_path(File.dirname(__FILE__)).split(File::SEPARATOR).last
  sh "bundle exec knife cookbook test #{cookbook} -o ../"
end

desc 'Executes chefspec specs'
task :chefspec do
  # sh "bundle exec rspec #{cookbooks_path}/*/spec"
end
