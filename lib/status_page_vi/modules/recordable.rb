module StatusPageVi
  module Recordable
    def self.included(klass)
      klass.extend(RecordableClassMethods)
    end

    module RecordableClassMethods
      def save(service = collection)
        data = collection.merge(service)
        update_storrage(data)

        @collection = nil
      end

      def list
        collection.map do |timestamp, options|
          self.new(timestamp, options)
        end
      end

      private

      def update_storrage(data)
        File.delete(cache_file_path) if File.exists?(cache_file_path)
        write_to_service_file(data)
      end

      def collection
        @collection ||= begin
          JSON.parse(File.read cache_file_path)
        rescue Errno::ENOENT
          {}
        end
      end

      def write_to_service_file(data)
        Dir.mkdir('cache') unless Dir.exists?('cache')
        File.open(cache_file_path, 'w') { |file| file.write(data.to_json) }
      end

      def cache_file_path
        "cache/#{self}.json"
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
