module ForemanDebian
  class Engine

    def initialize(app)
      @app = app
    end

    def install(jobs, concurrency, user, timeout_schedule)
      initd_engine = Initd::Engine.new(@app)
      monit_engine = Monit::Engine.new(@app)
      jobs.each do |name, command|
        if job_concurrency(concurrency, name) > 0
          script = initd_engine.create_script(name, command, user, timeout_schedule)
          initd_engine.install(script)
          monit_engine.install(name, script)
        end
      end
      initd_engine.cleanup
      monit_engine.cleanup
    end

    def uninstall
      stop
      Initd::Engine.new(@app).cleanup
      Monit::Engine.new(@app).cleanup
    end

    def start
      Initd::Engine.new(@app).start
    end

    def stop
      Initd::Engine.new(@app).stop
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
