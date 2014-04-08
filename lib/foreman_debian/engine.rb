module ForemanDebian
  class Engine

    def initialize(app, user)
      @app = app
      @user = user
      @initd_engine = Engine::Initd.new(@app, @user, '/tmp/init.d')
      @monit_engine = Engine::Monit.new(@app, @user, '/tmp/monit/conf.d', @initd_engine)
    end

    def install(jobs)
      jobs.each do |name, command|
        @initd_engine.install(name, command)
        @monit_engine.install(name, command)
      end
      @initd_engine.cleanup
      @monit_engine.cleanup
    end

    def uninstall
    end

  end
end
