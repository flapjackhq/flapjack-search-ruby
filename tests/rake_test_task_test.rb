# frozen_string_literal: true

require "minitest/autorun"
require "rake"

class RakeTestTaskTest < Minitest::Test
  RAKEFILE_PATH = File.expand_path("../Rakefile", __dir__)

  def setup
    @previous_application = Rake.application
    Rake.application = Rake::Application.new
    Object.send(:remove_const, :UNIT_TEST_FILES) if Object.const_defined?(:UNIT_TEST_FILES)
    Object.send(:remove_const, :E2E_TEST_FILES) if Object.const_defined?(:E2E_TEST_FILES)
    load RAKEFILE_PATH
  end

  def teardown
    Rake.application = @previous_application
  end

  def test_default_test_task_excludes_live_e2e_tests
    unit_test_files = Object.const_get(:UNIT_TEST_FILES).map(&:to_s)

    assert_includes unit_test_files, "tests/gemspec_metadata_test.rb"
    refute_includes unit_test_files, "tests/flapjack_search_e2e_test.rb"
  end
end
