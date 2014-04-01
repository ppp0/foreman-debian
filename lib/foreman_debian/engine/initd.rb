module ForemanDebian
  class Engine::Initd

    attr_accessor :app, :user, :export_path

    def initialize(app, user)
      @app = app
      @user = user
    end

    def install(name, command)
      name = "#{@app}-#{name}"
      pidfile = Pathname.new('/var/run').join(name).join(name + '.pid')
      args = Shellwords.split(command)
      script = args.shift

      template = Template.new('initd_script')
      puts template.render({
                               :name => name,
                               :user => @user,
                               :description => name,
                               :script => script,
                               :arguments => args,
                               :pidfile => pidfile,
                           })
    end


  end
end
