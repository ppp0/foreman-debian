module ForemanDebian
  module Initd
   class Script < Template::Storage

      attr_reader :path, :name, :description, :user, :script, :arguments, :pidfile

      def initialize(path, name, description, user, script, arguments, pidfile)
        @path = path
        @name = name
        @description = description
        @user = user
        @script = script
        @arguments = arguments
        @pidfile = pidfile
      end

      def render
        super('initd_script')
      end
    end
  end
end
