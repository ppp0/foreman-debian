Gem::Specification.new do |s|
  s.name = 'foreman_debian'
  s.version = ForemanDebian::VERSION
  s.summary = 'Foreman wrapper for debian'
  s.description = 'Simple wrapper providing installation of debian init script using foreman Procfile schema'
  s.authors = %w(cargomedia tomaszdurka)
  s.email = 'hello@cargomedia.ch'
  s.date = Date.today.to_s
  s.homepage = 'https://github.com/cargomedia/foreman-debian'
  s.license = 'MIT'

  s.files = Dir.glob 'lib/**/*'
  s.executables = ['foreman-debian']

  s.add_runtime_dependency 'clamp', '>= 0.5'
  s.add_runtime_dependency 'foreman', '>= 0.63.0'
  s.add_runtime_dependency 'term-ansicolor', '>= 1.2.0'
end
