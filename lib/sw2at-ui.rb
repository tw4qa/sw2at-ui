module Swat
  require 'fire-model'
  require 'swat/engine'
  require 'swat/ui/generators/install_generator'

  module UI
    require 'swat/ui/config'
    require 'swat/ui/rspec_setup'

    def self.setup(opts)
      config.options = opts
    end

    def self.rspec_config=(conf)
      config.rspec_config = conf
    end

    def self.config
      @config ||= Config.new
    end

  end
end
