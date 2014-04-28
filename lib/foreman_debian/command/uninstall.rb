module ForemanDebian
  class Command::Uninstall < Command

    def execute
      get_engine.uninstall
    end
  end
end
