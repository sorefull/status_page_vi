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
  RESOURCES = {
    'BitBucket' => BitBucket,
    'CloudFlareStatus' => CloudFlareStatus,
    'Github' => Github,
    'RubyGems' => RubyGems
  }.freeze

  class CLI < Thor
    desc "resources", "outputs avaliable resources with urls"
    def resources
      RESOURCES.each do |resource_name, resource_class|
        puts "#{resource_name} : #{resource_class::URL}"
      end
    end

    desc "pull RESOURCE_NAME", "make the application pull data from RESOURCE and save into the data store, ALL by default"
    method_option :value, :default => "some value"
    def pull(resource = 'ALL')

      StatusPageVi::PullService.call(
        RESOURCES[resource] || 'ALL'
      )
    end

    desc "live RESOURCE_NAME", "constantly queries URL and outputs the status periodically on the console and save it to the data store, ALL by default"
    def live(resource = 'ALL')
      loop do
        begin
          StatusPageVi::PullService.call(
            RESOURCES[resource] || 'ALL'
          )
        rescue Interrupt
          RESOURCES.values.each(&:save)
          break
        end
      end
    end

    desc "history RESOURCE_NAME", "display all the data which was gathered by the tool, ALL by default"
    def history(resource = 'ALL')
      StatusPageVi::HistoryService.call(
        RESOURCES[resource] || 'ALL'
      )
    end
  end
end
