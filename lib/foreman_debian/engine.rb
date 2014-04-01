module ForemanDebian
  class Engine

    def initialize(app, user)
      @app = app
      @user = user
      @initd_engine = Engine::Initd.new(@app, @user)
      @monit_engine = Engine::Monit.new(@app, @user)
    end

    def install(jobs)
      jobs.each do |name, command|
        @initd_engine.install(name, command)
        @monit_engine.install(name, command)
      end
    end

    def uninstall
    end

  end
end
