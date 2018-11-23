module StatusPageVi
  class BaseService
    def self.resources(resource_name)
      return StatusPageVi::RESOURCES.values if resource_name == "ALL"
      [ resource_name ]
    end
  end
end
