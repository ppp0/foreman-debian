module ForemanDebian
  class CommandManager < Clamp::Command

    subcommand 'install', 'Install', Command::Install
    subcommand 'uninstall', 'Uninstall', Command::Uninstall
    subcommand 'start', 'Start', Command::Start
    subcommand 'stop', 'Stop', Command::Stop
  end
end
