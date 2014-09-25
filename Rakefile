$:.unshift File.expand_path('../lib', __FILE__)
require 'foreman_debian'
require 'bundler/setup'
require 'bundler/gem_tasks'

Dir.glob(Pathname.new(__FILE__).dirname.join('tasks/**/*.rake')).each do |task|
  load task
end
