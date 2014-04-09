require 'spec_helper'
require 'foreman_debian'

describe ForemanDebian::Initd::Engine, :fakefs do

  let(:engine) { ForemanDebian::Initd::Engine.new('app', 'app-user') }

  it 'creates script' do
    script = engine.create_script('foo', 'foo arg1')
    script.path.to_s.should eql('/etc/init.d/app-foo')
    script.name.should eql('app-foo')
    script.description.should eql('app-foo')
    script.user.should eql('app-user')
    script.arguments.should eql(['arg1'])
    script.pidfile.to_s.should eql('/var/run/app-foo/app-foo.pid')
  end
end
