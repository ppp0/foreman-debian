require 'foreman/procfile'

module ForemanDebian
  class Command < Clamp::Command

    include Term::ANSIColor

    option %w(-a --app), '<name>', 'application name',
           :attribute_name => :app_name,
           :default => 'app'
    option %w(-u --user), '<user>', 'Specify the user the application should be run as',
           :attribute_name => :app_user,
           :default => 'root'

    # @return [ForemanDebian::Engine]
    def get_engine
      ForemanDebian::Engine.new(app_name, app_user)
    end

    def run_colorify(arguments)
      begin
        super
      rescue Clamp::RuntimeError => e
        raise e
      rescue Exception => e
        print on_red ' '
        print bold ' Error: '
        puts e.class
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
