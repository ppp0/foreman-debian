module ForemanDebian
  class Command::Start < Command

    def execute
      get_engine.start
    end
  end
end
