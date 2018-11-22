module StatusPageVi
  class PullService < BaseService
    def self.call(option = nil)
      resources(option).each(&:pull)
    end
  end
end
