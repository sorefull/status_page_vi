module StatusPageVi
  class HistoryService < BaseService
    def self.call(option = nil)
      resources(option).each(&:print_history)
    end
  end
end
