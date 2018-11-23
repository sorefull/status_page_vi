require "status_page_vi/resources/base_resource"
require "status_page_vi/resources/bit_bucket"
require "status_page_vi/resources/cloud_flare_status"
require "status_page_vi/resources/github"
require "status_page_vi/resources/ruby_gems"

require "status_page_vi/services/base_service"
require "status_page_vi/services/pull_service"
require "status_page_vi/services/history_service"
require "status_page_vi/services/backup_service"

require "status_page_vi/validators/backup_file_validator"

require "status_page_vi/errors"

require "thor"
require 'nokogiri'
require 'open-uri'
require 'json'

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

    desc "pull RESOURCE_NAME", "make the application pull data from RESOURCE and save into the data store, ALL resources by default"
    def pull(resource = 'ALL')
      raise InvalidResource unless valid_resource?(resource)

      StatusPageVi::PullService.call(
        RESOURCES[resource] || resource
      )
    end

    desc "live RESOURCE_NAME", "constantly queries URL and outputs the status periodically on the console and save it to the data store, ALL resources by default"
    def live(resource = 'ALL')
      raise InvalidResource unless valid_resource?(resource)

      loop do
        begin
          StatusPageVi::PullService.call(
            RESOURCES[resource] || resource
          )
        rescue Interrupt
          break
        end
      end
    end

    desc "history RESOURCE_NAME", "display all the data which was gathered by the tool, ALL resources by default"
    def history(resource = 'ALL')
      raise InvalidResource unless valid_resource?(resource)

      StatusPageVi::HistoryService.call(
        RESOURCES[resource] || resource
      )
    end

    desc "backup PATH RESOURCE_NAME", "takes a path variable, and creates a backup of historic and currently saved data, ALL resources by default"
    def backup(path, resource = 'ALL')
      raise InvalidResource unless valid_resource?(resource)

      StatusPageVi::BackupService.backup(
        path,
        RESOURCES[resource] || resource
      )
    end

    desc "restore PATH_TO_BACKUP", "takes a path variable which is a backup created by the application and restores that data"
    def restore(path_to_file)
      StatusPageVi::BackupService.restore(path_to_file)
    end

    private

    def valid_resource?(resource)
      return true if RESOURCES[resource] || resource == 'ALL'
    end
  end
end
