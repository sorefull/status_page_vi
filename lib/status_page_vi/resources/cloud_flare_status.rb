module StatusPageVi
  class CloudFlareStatus < BaseResource
    URL = 'https://www.cloudflarestatus.com'.freeze

    private

    def stats_good?
      self.scraper.css('span.status.font-large').first.text ==
        "\n            All Systems Operational\n          "
    end
  end
end
