module ForemanDebian
  module Initd
    class Engine

      include ForemanDebian::Engine::Helper

      attr_reader :export_path

      def initialize(app, user, export_path = nil)
        @app = app
        @user = user
        @export_path = Pathname.new(export_path || '/etc/init.d')
        @system_export_path = Pathname.new('/etc/init.d')
        setup
      end

      def create_script(name, command)
        pidfile = pidfile(name)
        args = Shellwords.split(command)
        script = args.shift
        name = "#{@app}-#{name}"
        script_path = @export_path.join(name)
        Script.new(script_path, name, name, @user, script, args, pidfile)
      end

      def install(script)
        FileUtils.mkdir_p(script.path.dirname)
        File.open(script.path, 'w') do |file|
          file.puts(script.render)
          file.chmod(0755)
          export_file(script.path)
        end
        exec_command("update-rc.d #{script.path.basename} defaults") if script.path.dirname.eql? @system_export_path
      end

      def start
        each_file do |path|
          exec_command("#{path.to_s} start")
        end
      end

      def stop
        each_file do |path|
          exec_command("#{path.to_s} stop")
        end
      end

      def remove_file(path)
        exec_command("update-rc.d #{path.basename} remove") if path.dirname.eql? @system_export_path
        super(path)
      end

      def exec_command(command)
        `#{command}`
      end
    end
  end
end
