module ForemanDebian
  class Engine::Monit

    attr_accessor :app, :user, :export_path

    def initialize(app, user)
      @app = app
      @user = user
    end

    def install(name, command)

    end
  end
end
