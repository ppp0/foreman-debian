module ForemanDebian
  class Engine

    attr_accessor :name, :user

    def initialize(name, user)
      @name = name
      @user = user
    end

    def install(jobs)
      puts jobs
    end

    def uninstall
    end

  end
end
