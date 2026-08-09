# frozen_string_literal: true

require "minitest/autorun"
require "flapjack"

class DefaultHostsTest < Minitest::Test
  APP_ID = "app"
  API_KEY = "key"

  def host_urls(client)
    client.api_client.config.hosts.map(&:url)
  end

  def test_nil_region_hosts_use_flapjack_domains
    cases = [
      [Flapjack::AbtestingClient, ["analytics.flapjack.io"]],
      [Flapjack::AbtestingV3Client, ["analytics.flapjack.io"]],
      [Flapjack::AnalyticsClient, ["analytics.flapjack.io"]]
    ]

    cases.each do |client_class, expected_urls|
      assert_equal expected_urls, host_urls(client_class.create(APP_ID, API_KEY))
    end
  end

  def test_optional_region_hosts_use_flapjack_domains
    # The regional branch is a distinct selector from the nil-region branch;
    # assert it explicitly so a regression on the regional side fails.
    cases = [
      [Flapjack::AbtestingClient, "de", ["analytics.de.flapjack.io"]],
      [Flapjack::AbtestingV3Client, "us", ["analytics.us.flapjack.io"]],
      [Flapjack::AnalyticsClient, "de", ["analytics.de.flapjack.io"]]
    ]

    cases.each do |client_class, region, expected_urls|
      assert_equal expected_urls, host_urls(client_class.create(APP_ID, API_KEY, region))
    end
  end

  def test_required_region_hosts_use_flapjack_domains
    cases = [
      [Flapjack::IngestionClient, "eu", ["data.eu.flapjack.io"]],
      [Flapjack::PersonalizationClient, "us", ["personalization.us.flapjack.io"]],
      [Flapjack::QuerySuggestionsClient, "eu", ["query-suggestions.eu.flapjack.io"]]
    ]

    cases.each do |client_class, region, expected_urls|
      assert_equal expected_urls, host_urls(client_class.create(APP_ID, API_KEY, region))
    end
  end

  def test_insights_hosts_use_flapjack_domains
    cases = [
      [nil, ["insights.flapjack.io"]],
      ["de", ["insights.de.flapjack.io"]],
      ["us", ["insights.us.flapjack.io"]]
    ]

    cases.each do |region, expected_urls|
      assert_equal expected_urls, host_urls(Flapjack::InsightsClient.create(APP_ID, API_KEY, region))
    end
  end
end
