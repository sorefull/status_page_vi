module StatusPageVi
  class BackupService < BaseService
    def self.backup(path, resource)
      resources(resource).each do |resource_class|
        FileUtils.cp(
          resource_class.cache_file_path,
          "#{path}/#{resource_class.name.split("::").last}.json"
        )
      end
    end

    def self.restore(path_to_file)
      validator = StatusPageVi::BackupFileValidator.new(path_to_file)

      raise InvalidBackup unless validator.valid_backup?

      validator.resource.update_storage(validator.json_data)
    end
  end
end
