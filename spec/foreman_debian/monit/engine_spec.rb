require 'spec_helper'
require 'foreman_debian'

describe ForemanDebian::Initd::Engine, :fakefs do

  let(:engine) { ForemanDebian::Monit::Engine.new('app', 'app-user') }

  it 'install script' do
    initd_engine = ForemanDebian::Initd::Engine.new('initd-app', 'initd-app-user')
    script = initd_engine.create_script('initd-foo', 'initd-bar arg1 arg2')
    engine.install('foo', script)
    File.read('/etc/monit/conf.d/app-foo').should == spec_resource('monit_config/app-foo')
  end
end
