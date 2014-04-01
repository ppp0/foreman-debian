module ForemanDebian
  class Command < Clamp::Command

    include Term::ANSIColor

    def run(arguments)
      begin
        super
      rescue Exception => e
        print on_red ' '
        print bold ' Error: '
        if e.message.empty?
          puts 'Unknown error/Interrupt'
        else
          puts e.message
        end
        exit 1
      end
    end
  end
end
