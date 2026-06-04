# frozen_string_literal: true

require "minitest/autorun"

lib_path = File.expand_path("../lib", __dir__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require "flapjack/version"

class GemspecMetadataTest < Minitest::Test
  GEMSPEC_PATH = File.expand_path("../flapjack-search.gemspec", __dir__)

  def spec
    @spec ||= Gem::Specification.load(GEMSPEC_PATH)
  end

  def test_required_ruby_version_rejects_ruby_2_6_10
    refute spec.required_ruby_version.satisfied_by?(Gem::Version.new("2.6.10"))
  end

  def test_required_ruby_version_accepts_ruby_2_7_0
    assert spec.required_ruby_version.satisfied_by?(Gem::Version.new("2.7.0"))
  end

  def test_gemspec_version_uses_canonical_version_binding
    assert_equal Flapjack::VERSION, spec.version.to_s
  end
end
