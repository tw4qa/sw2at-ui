module Swat
  module UI
    require 'swat/ui/version'
    require 'swat/ui/rspec_setup'
    require 'swat/ui/rspec_commands'

    class Config

      def initialize(rspec_config, opts = {})
        @options = opts
        if rspec_config
          rspec_config.extend RspecSetup
          rspec_config.formatter = Swat::UI::RspecSetup::Formatter
        end
      end

      def options
        @options
      end

    end
  end
end
