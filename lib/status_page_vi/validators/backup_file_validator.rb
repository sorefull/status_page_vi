module StatusPageVi
  class BackupFileValidator
    attr_accessor :file_path, :resource, :json_data

    def initialize(file_path)
      self.file_path = file_path
    end

    def valid_backup?
      extention = File.extname(self.file_path)
      return false if extention != ".json"

      file_name = File.basename(self.file_path, extention)
      self.resource = RESOURCES[file_name]
      return false unless self.resource

      begin
        self.json_data = JSON.parse(File.read(self.file_path))
      rescue JSON::ParserError
        return false
      end
    end
  end
end
