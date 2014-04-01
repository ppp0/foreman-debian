module ForemanDebian
  class Engine::Initd

    include ForemanDebian::Engine::Helper

    def initialize(app, user, export_path = nil)
      setup
      @app = app
      @user = user
      @export_path = Pathname.new(export_path || '/etc/init.d')
    end

    def install(name, command)
      name = "#{@app}-#{name}"
      pidfile = Pathname.new('/var/run').join(name).join(name + '.pid')
      args = Shellwords.split(command)
      script = args.shift

      FileUtils.mkdir_p(@export_path)
      template = Template.new('initd_script')
      output = template.render({
                                   :name => name,
                                   :user => @user,
                                   :description => name,
                                   :script => script,
                                   :arguments => args,
                                   :pidfile => pidfile,
                               })
      script_path = @export_path.join(name)
      File.open(script_path, 'w') do | file|
        file.puts(output)
        file.chmod(0755)
        export_file(script_path)
      end
    end
  end
end
