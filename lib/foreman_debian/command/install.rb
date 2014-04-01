module ForemanDebian
  class Command::Install < Command

    option %w(-f --procfile), '<path>', 'alternative Procfile',
           :attribute_name => :optional_procfile,
           :default => 'Procfile'

    def execute
      jobs = {}
      procfile.entries do |name, command|
        args = Shellwords.split(command)
        args[0] = Pathname.new(args[0]).expand_path(dir_root)
      jobs[name] = Shellwords.join(args)
      end
      get_engine.install(jobs)
    end

    # @return [Pathname]
    def procfile_path
      Pathname.new(optional_procfile).expand_path(Dir.getwd)
    end

    # @return [Foreman::Procfile]
    def procfile
      raise "Procfile `#{procfile_path.to_s}` does not exist"  unless procfile_path.file?
      Foreman::Procfile.new(procfile_path)
    end

    # @return [Pathname]
    def dir_root
      procfile_path.dirname
    end
  end
end
