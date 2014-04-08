module ForemanDebian
  module Monit
    class Engine

      include ForemanDebian::Engine::Helper

      def initialize(app, user, export_path = nil, initd_engine)
        @app = app
        @user = user
        @export_path = Pathname.new(export_path || '/etc/monit/conf.d')
        @scripts_path = Pathname.new(scripts_path || '/etc/init.d')
        @initd_engine = initd_engine
        setup
      end

      def install(name, script_path)
        pidfile = pidfile(name)
        name = "#{@app}-#{name}"

        FileUtils.mkdir_p(@export_path)
        template = Template.new('monit_config')
        output = template.render({
                                     :app => @app,
                                     :name => name,
                                     :pidfile => pidfile,
                                     :script => @scripts_path.join(name)
                                 })
        script_path = @export_path.join(name)
        File.open(script_path, 'w') do |file|
          file.puts(output)
          export_file(script_path)
        end
      end
    end
  end
end
