module ForemanDebian
  class Engine::Initd

    attr_accessor :app, :user, :export_path

    def initialize(app, user)
      @app = app
      @user = user
    end

    def install(name, command)
      args = Shellwords.split(command)
      script = args.shift
    end
  end
end
