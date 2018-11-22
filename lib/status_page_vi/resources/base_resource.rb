require "status_page_vi/modules/recordable"

module StatusPageVi
  class BaseResource
    include StatusPageVi::Recordable

    def self.pull
      resource = self.new
      resource.call
      resource.save

      puts resource
    end

    def self.print_history
      puts "-------#{self}-------"
      self.list.each { |resource| puts resource }
      puts
    end

    attr_accessor :timestamp, :options, :scraper

    def call
      self.scraper = Nokogiri::HTML(open(self.class::URL))
      get_data
    end

    def get_data
      self.timestamp = Time.now
      self.options['status'] = stats_good? ? 'good' : 'bad'
    end

    def to_h
      { self.timestamp => { 'status' => self.options['status'] } }
    end

    def to_s
      "#{self.class}: #{self.timestamp} : #{self.options['status']}"
    end
  end
end
