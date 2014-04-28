require 'foreman/procfile'

module ForemanDebian
  class Command < Clamp::Command

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
  end
end
