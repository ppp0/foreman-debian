require 'fakefs/safe'
require 'fakefs/spec_helpers'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true

  c.before(:each) do
    FakeFS.activate!
  end

  c.after(:each) do
    FakeFS.deactivate!
  end
end

def spec_resource (name)
  FakeFS.deactivate!
  contents = Pathname.new('resources/stubs').expand_path(__dir__).join(name).read
  FakeFS.activate!
  contents
end
