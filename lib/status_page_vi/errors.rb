module StatusPageVi
  class InvalidResource < StandardError
    def initialize(msg = "Resource is invalid, shoud be one of: #{RESOURCES.keys.join(" ,")}.")
      super(msg)
    end
  end

  class InvalidBackup < StandardError
    def initialize(msg = "Backup file is invalid")
      super(msg)
    end
  end
end
