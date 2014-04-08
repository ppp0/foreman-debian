module ForemanDebian
  class Engine

    def initialize(app, user)
      @app = app
      @user = user
      @initd_engine = Initd::Engine.new(@app, @user, '/tmp/init.d')
      @monit_engine = Monit::Engine.new(@app, @user, '/tmp/monit/conf.d')
    end

    def install(jobs)
      jobs.each do |name, command|
        script = @initd_engine.create_script(name, command)
        @initd_engine.install(script)
        @monit_engine.install(name, script)
      end
      @initd_engine.cleanup
      @monit_engine.cleanup
    end

    def uninstall
      install({})
    end

    def start
      @initd_engine.start
    end

    def stop
      @initd_engine.stop
    end
  end
end
