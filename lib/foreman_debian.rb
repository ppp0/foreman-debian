module ForemanDebian
  require 'clamp'
  require 'term/ansicolor'
  require 'io/console'
  require 'json'
  require 'pathname'
  require 'foreman_debian/engine'
  require 'foreman_debian/command'
  require 'foreman_debian/command/uninstall'
  require 'foreman_debian/command/install'
  require 'foreman_debian/command_manager'
end
