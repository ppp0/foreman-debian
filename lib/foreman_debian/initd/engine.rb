module ForemanDebian
  module Initd
    class Engine

      include ForemanDebian::EngineHelper

      def initialize(app, export_path = nil)
        @app = app
        @export_path = Pathname.new(export_path || '/etc/init.d')
        @system_export_path = Pathname.new('/etc/init.d')
        setup
      end

      def create_script(name, command, user, timeout_schedule = '20')
        pidfile = pidfile(name)
        args = Shellwords.split(command)
        script = args.shift
        name = "#{@app}-#{name}"
        script_path = @export_path.join(name)
        Script.new(script_path, name, name, user, script, args, pidfile, timeout_schedule)
      end

      def install(script)
        FileUtils.mkdir_p(script.path.dirname)
        File.open(script.path, 'w') do |file|
          file.puts(script.render)
          file.chmod(0755)
          export_file(script.path)
        end
      end

      def start
        each_file do |path|
          start_file(path)
        end
      end

      def stop
        each_file do |path|
          stop_file(path)
        end
      end

      def start_file(path)
        exec_command("#{path.to_s} start")
        @output.info " start  #{path.to_s}"
        exec_command("update-rc.d #{path.basename} defaults") if path.dirname.eql? @system_export_path
      end

      def stop_file(path)
        exec_command("#{path.to_s} stop")
        @output.info "  stop  #{path.to_s}"
        exec_command("update-rc.d -f #{path.basename} remove") if path.dirname.eql? @system_export_path
      end

      def remove_file(path)
        stop_file(path)
        super(path)
      end
    end
  end
end
