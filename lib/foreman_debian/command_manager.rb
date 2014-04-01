module ForemanDebian
  class CommandManager < Clamp::Command

    subcommand 'install', 'Install', Command::Install
    subcommand 'uninstall', 'Uninstall', Command::Uninstall
  end
end
