$:.unshift File.expand_path('../lib', __FILE__)
require 'foreman_debian'
require 'bundler/setup'

Dir.glob(Pathname.new('tasks/**/*.rake').expand_path(__dir__)).each do |task|
  load task
end
