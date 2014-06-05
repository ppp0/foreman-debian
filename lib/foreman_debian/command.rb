require 'foreman/procfile'

module ForemanDebian
  class Command < Clamp::Command

    option %w(-a --app), '<name>', 'application name',
           :attribute_name => :app,
           :default => 'app'

    # @return [ForemanDebian::Engine]
    def get_engine
      ForemanDebian::Engine.new(app)
    end
  end
end
