module Swat
  module UI
    require 'swat/ui/config'
    require 'swat/ui/routes'

    def self.setup(rspec_config, opts)
      @config = Config.new(rspec_config, opts)
    end

    def self.config
      @config
    end

  end
end
