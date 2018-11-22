require "status_page_vi/resources/base_resource"
require "status_page_vi/resources/bit_bucket"
require "status_page_vi/resources/cloud_flare_status"
require "status_page_vi/resources/github"
require "status_page_vi/resources/ruby_gems"

require "status_page_vi/services/base_service"
require "status_page_vi/services/pull_service"
require "status_page_vi/services/history_service"
require "status_page_vi/services/backup_service"

require "thor"
require 'nokogiri'
require 'open-uri'

require 'pry'

module StatusPageVi
  RESOURCES = [ BitBucket, CloudFlareStatus, Github, RubyGems ].freeze

  class CLI < Thor
    desc "resources", "outputs avaliable resources with urls"
    def resources
      RESOURCES.each do |resource_class|
        puts "#{resource_class} : #{resource_class::URL}"
      end
    end

    desc "pull", "make the application pull all the status page data from different providers and save into the data store"
    def pull
      StatusPageVi::PullService.call(:all)
    end

    desc "live", "constantly queries the URLs and outputs the status periodically on the console and save it to the data store"
    def live
      loop do
        begin
          StatusPageVi::PullService.call(:all)
        rescue Interrupt
          RESOURCES.each(&:save)
          break
        end
      end
    end

    desc "history", "make the application pull all the status page data from different providers and save into the data store"
    def history
      StatusPageVi::HistoryService.call(:all)
    end
  end
end
