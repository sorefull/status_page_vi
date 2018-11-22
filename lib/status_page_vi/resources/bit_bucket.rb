module StatusPageVi
  class BitBucket < BaseResource
    URL = 'https://status.bitbucket.org'.freeze

    private

    def stats_good?
      self.scraper.css('span.status.font-large').first.text ==
        "\n            All Systems Operational\n          "
    end
  end
end
