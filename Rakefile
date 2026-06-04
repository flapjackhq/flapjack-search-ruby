require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |task|
  task.libs << 'lib'
  task.test_files = FileList['tests/*_test.rb']
end

task(:default) { system 'rake --tasks' }
