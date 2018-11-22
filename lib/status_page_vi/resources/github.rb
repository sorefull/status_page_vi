module StatusPageVi
  class Github < BaseResource
    URL = "https://status.github.com/messages".freeze

    private

    def stats_good?
      self.scraper.css(".logo a img").attr("src").value == "/images/logo-good.png"
    end
  end
end
