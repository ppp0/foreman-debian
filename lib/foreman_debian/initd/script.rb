module ForemanDebian
  module Initd
   class Script < Template::Storage

      attr_reader :path, :name, :description, :user, :script, :arguments, :pidfile, :timeout_schedule

      def initialize(path, name, description, user, script, arguments, pidfile, timeout_schedule)
        @path = path
        @name = name
        @description = description
        @user = user
        @script = script
        @arguments = arguments
        @pidfile = pidfile
        @timeout_schedule = timeout_schedule
      end

      def render
        super('initd_script')
      end
    end
  end
end
