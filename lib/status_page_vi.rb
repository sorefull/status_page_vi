require "status_page_vi/resources/base_resource"
require "status_page_vi/resources/bit_bucket"
require "status_page_vi/resources/cloud_flare_status"
require "status_page_vi/resources/github"
require "status_page_vi/resources/ruby_gems"

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

    desc "pull", "outputs the list of services and data about them"
    def pull
      StatusPageVi::PullService.call(:all)
    end
  end
end
