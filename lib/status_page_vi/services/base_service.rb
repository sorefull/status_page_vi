module StatusPageVi
  class BaseService
    def self.resources(option)
      if option == "ALL"
        StatusPageVi::RESOURCES.values
      elsif StatusPageVi::RESOURCES.values.include?(option)
        [ option ]
      else
        []
      end
    end
  end
end
