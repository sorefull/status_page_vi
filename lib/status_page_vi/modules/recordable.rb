module StatusPageVi
  module Recordable
    def self.included(klass)
      klass.extend(RecordableClassMethods)
    end

    module RecordableClassMethods
      def save(service)
        data = collection.merge(service)
        update_storage(data)

        @collection = nil
      end

      def list
        collection.map do |timestamp, options|
          self.new(timestamp, options)
        end
      end

      def cache_file_path
        "#{__dir__}/../../../cache/#{self}.json"
      end

      def update_storage(data)
        File.delete(cache_file_path) if File.exists?(cache_file_path)
        write_to_service_file(data)
      end

      private

      def collection
        @collection ||= begin
          JSON.parse(File.read cache_file_path)
        rescue Errno::ENOENT
          {}
        end
      end

      def write_to_service_file(data)
        Dir.mkdir("cache") unless Dir.exists?("cache")
        File.open(cache_file_path, "w") { |file| file.write(data.to_json) }
      end
    end

    def initialize(timestamp = nil, options = {})
      self.timestamp = timestamp
      self.options = options
    end

    def save
      self.class.save(self.to_h)
      self
    end
  end
end
