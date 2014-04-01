module ForemanDebian
  class Command::Uninstall < Command

    def execute
      get_engine.install({})
    end
  end
end
