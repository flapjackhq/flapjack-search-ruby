require 'bundler/gem_tasks'
require 'rake/testtask'

UNIT_TEST_FILES = FileList['tests/*_test.rb'].exclude('tests/flapjack_search_e2e_test.rb').to_a.freeze
E2E_TEST_FILES = FileList['tests/flapjack_search_e2e_test.rb'].to_a.freeze

Rake::TestTask.new(:test) do |task|
  task.libs << 'lib'
  task.test_files = UNIT_TEST_FILES
end

Rake::TestTask.new(:e2e) do |task|
  task.libs << 'lib'
  task.test_files = E2E_TEST_FILES
end

task(:default) { system 'rake --tasks' }
