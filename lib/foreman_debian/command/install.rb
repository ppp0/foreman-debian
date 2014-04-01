module ForemanDebian
  class Command::Install < Command

    option %w(-f --procfile), '<path>', 'alternative Procfile',
           :attribute_name => :optional_procfile,
           :default => 'Procfile'

    def execute

      procfile = get_procfile
      jobs = {}
      procfile.entries do |name, command|
        jobs[name] = command
      end
      get_engine.install(jobs)
    end

    # @return [Foreman::Procfile]
    def get_procfile
      procfile = Pathname.new(optional_procfile).expand_path(Dir.getwd)
      raise "Procfile `#{procfile.to_s}` does not exist"  unless procfile.file?
      Foreman::Procfile.new(procfile)
    end
  end
end
