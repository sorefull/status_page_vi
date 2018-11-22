module StatusPageVi
  class PullService
    def self.call(option = nil)
      resources = if option == :all
        StatusPageVi::RESOURCES
      elsif StatusPageVi::RESOURCES.include?(option)
        [ option ]
      else
        []
      end

      resources.each(&:pull)
    end
  end
end
