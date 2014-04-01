module ForemanDebian
  class Command::Install < Command

    def execute
      $stderr.puts 'foo'
    end
  end
end
