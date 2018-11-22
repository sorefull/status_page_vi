module StatusPageVi
  class RubyGems < BaseResource
    URL = 'https://status.rubygems.org'.freeze

    private

    def stats_good?
      self.scraper.css('.page-status.status-none span').first.text ==
        "\n            All Systems Operational\n          "
    end
  end
end
