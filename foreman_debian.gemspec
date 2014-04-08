Gem::Specification.new do |s|

  s.name = 'foreman_debian'
  s.authors = ['Cargomedia']
  s.date = Date.today.to_s
  s.email = 'tomasz.durka@cargomedia.ch'
  s.homepage = 'https://github.com/cargomedia/foreman-debian.git'
  s.license = 'MIT'

  s.summary = 'Foreman wrapper for debian'
  s.version = '0.0.1'

  s.add_runtime_dependency 'clamp', '>= 0.5'
  s.add_runtime_dependency 'foreman', '>= 0.63.0'
  s.add_runtime_dependency 'term-ansicolor', '>= 1.2.0'

  s.files = Dir.glob 'lib/**/*'
  s.executables = ['foreman-debian']
end
