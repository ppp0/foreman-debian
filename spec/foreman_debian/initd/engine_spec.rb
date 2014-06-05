require 'spec_helper'

describe ForemanDebian::Initd::Engine, :fakefs do

  module ForemanDebian::EngineHelper
    attr_reader :commands_run

    def exec_command(command)
      @commands_run ||= []
      @commands_run.push command
    end
  end

  let(:engine) { ForemanDebian::Initd::Engine.new('app', 'app-user') }

  it 'creates script' do
    script = engine.create_script('foo', 'foo arg1 arg2')

    expect(script.path.to_s) == '/etc/init.d/app-foo'
    expect(script.name) == 'app-foo'
    expect(script.description) == 'app-foo'
    expect(script.user) == 'app-user'
    expect(script.arguments) == %w(arg1 arg2)
    expect(script.pidfile.to_s) == '/var/run/app-foo/app-foo.pid'
  end

  it 'installs script' do
    script = engine.create_script('foo', 'bar arg1 arg2')
    engine.install(script)
    expect(File.read('/etc/init.d/app-foo')) == spec_resource('initd_script/app-foo')
  end

  it 'starts script' do
    script_path = Pathname.new('/etc/init.d/foo')
    engine.start_file(script_path)
    expect(engine.commands_run) == ['/etc/init.d/foo start', 'update-rc.d foo defaults']
  end

  it 'stops script' do
    script_path = Pathname.new('/etc/init.d/foo')
    engine.stop_file(script_path)
    expect(engine.commands_run) == ['/etc/init.d/foo stop', 'update-rc.d foo remove']
  end
end
