require 'rubygems'
require 'bundler'

require 'foodcritic'
fc_task = FoodCritic::Rake::LintTask.new
fc_task.options = { fail_tags: %w(any) }

Bundler.setup

require 'berkshelf'

# FileUtils.rm_rf('vendor/cookbooks')
# berksfile = Berkshelf::Berksfile.from_file('Berksfile')
# berksfile.install(path: 'vendor/cookbooks')

require 'rubocop/rake_task'
Rubocop::RakeTask.new

task default: [:foodcritic, :knife, :rubocop, :chefspec]

desc 'Validates cookbook with "knife cookbook" command'
task :knife do
  Rake::Task[:prepare_sandbox].execute
  sh "bundle exec knife cookbook test #{cookbook_name} -o #{sandbox_path}/../"
end

# http://www.nathenharvey.com/blog/2012/07/06/mvt-knife-test-and-travisci

task :prepare_sandbox do
  files = %w{*.md *.rb attributes definitions files libraries providers recipes resources templates}

  rm_rf sandbox_path
  mkdir_p sandbox_path
  cp_r Dir.glob("{#{files.join(',')}}"), sandbox_path
end

private

def cookbook_name
  'teamcity'.freeze
end

def sandbox_path
  File.join(File.dirname(__FILE__), ['tmp', 'cookbooks', cookbook_name])
end

desc 'Executes chefspec specs'
task :chefspec do
  sh "bundle exec rspec"
end
