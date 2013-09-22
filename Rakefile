cookbooks_path = 'site-cookbooks'

require 'rubygems'
require 'bundler'

require 'pathname'

require 'foodcritic'
FoodCritic::Rake::LintTask.new do |task|
  task.files = [cookbooks_path]
end

Bundler.setup

task default: %i(foodcritic knife chefspec)

desc 'Validates cookbook with "knife cookbook" command'
task :knife do
  Dir.glob("#{cookbooks_path}/*").each do |dir|
    cookbook = Pathname.new(dir).basename.to_s
    sh "bundle exec knife cookbook test #{cookbook} -o #{cookbooks_path}"
  end
end

desc 'Executes chefspec specs'
task :chefspec do
  # sh "bundle exec rspec #{cookbooks_path}/*/spec"
end
