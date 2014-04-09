require 'spec_helper'
require 'foreman_debian'

describe ForemanDebian::Initd::Engine, :fakefs do

  let(:engine) { ForemanDebian::Initd::Engine.new('app', 'app-user') }

  it 'creates script' do
    script = engine.create_script('foo', 'foo arg1 arg2')

    script.path.to_s.should == '/etc/init.d/app-foo'
    script.name.should == 'app-foo'
    script.description.should == 'app-foo'
    script.user.should == 'app-user'
    script.arguments.should == %w(arg1 arg2)
    script.pidfile.to_s.should == '/var/run/app-foo/app-foo.pid'
  end

  it 'install script' do
    script = engine.create_script('foo', 'bar arg1 arg2')
    engine.install(script)
    File.read('/etc/init.d/app-foo').should == spec_resource('initd_script/app-foo')
  end
end
