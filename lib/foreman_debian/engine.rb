module ForemanDebian
  class Engine

    def initialize(app, user)
      @app = app
      @user = user
      @initd_engine = Initd::Engine.new(@app, @user)
      @monit_engine = Monit::Engine.new(@app, @user)
    end

    def install(jobs, concurrency)
      jobs.each do |name, command|
        if job_concurrency(concurrency, name) > 0
          script = @initd_engine.create_script(name, command)
          @initd_engine.install(script)
          @monit_engine.install(name, script)
        end
      end
      @initd_engine.cleanup
      @monit_engine.cleanup
    end

    def uninstall
      install({}, {})
    end

    def start
      @initd_engine.start
    end

    def stop
      @initd_engine.stop
    end

    def job_concurrency(concurrency, name)
      c = (concurrency['all'] || 0).to_i
      if concurrency.has_key?(name)
        c = concurrency[name].to_i
      end
      c
    end
  end
end
