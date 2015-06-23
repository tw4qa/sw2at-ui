module Swat
  module UI
    require 'swat/ui/version'
    require 'swat/ui/rspec_setup'
    require 'swat/ui/rspec_commands'

    class Config

      def rspec_config=(conf)
        conf.extend RspecSetup
        conf.formatter = Swat::UI::RspecSetup::Formatter
      end

      def options=(opts)
        @options = opts
        Fire.setup(opts)
      end

      def options
        @options
      end

    end
  end
end
