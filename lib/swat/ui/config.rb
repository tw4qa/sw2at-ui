module Swat
  module UI
    require 'swat/ui/rspec_setup'

    class Config

      def initialize(rspec_config, opts = {})
        @options = opts
        rspec_config.extend RspecSetup
      end

      def options
        @options
      end

    end
  end
end
