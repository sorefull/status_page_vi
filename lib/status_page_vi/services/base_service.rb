module StatusPageVi
  class BaseService
    def self.resources(option)
      if option == :all
        StatusPageVi::RESOURCES
      elsif StatusPageVi::RESOURCES.include?(option)
        [ option ]
      else
        []
      end
    end
  end
end
