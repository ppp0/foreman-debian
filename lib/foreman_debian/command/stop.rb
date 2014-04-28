module ForemanDebian
  class Command::Stop < Command

    def execute
      get_engine.stop
    end
  end
end
