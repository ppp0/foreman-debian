module ForemanDebian
  class Engine::Initd

    attr_accessor :app, :user

    def initialize(app, user)
      @app = app
      @user = user
      @export_path = Pathname.new('/etc/init.d')
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
      File.open(@export_path.join(name), 'w') do | file|
        file.puts(output)
        file.chmod(0755)
      end
    end
  end
end
