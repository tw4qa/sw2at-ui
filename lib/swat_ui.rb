module Swat
  require 'swat/engine'

  module UI
    require 'swat/ui/config'
    require 'swat/ui/rspec_setup'

    def self.setup(rspec_config, opts)
      @config = Config.new(rspec_config, opts)
    end

    def self.config
      @config
    end

  end
end
