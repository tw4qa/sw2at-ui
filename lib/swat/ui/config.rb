module Swat
  module UI
    require 'swat/ui/version'
    require 'swat/ui/rspec_setup'
    require 'swat/ui/rspec_commands'

    class Config

      def initialize(rspec_config, opts = {})
        print_debug if RSpecCommands::CommandsBuilder.debug_mode?
        @options = opts
        rspec_config.extend RspecSetup
        rspec_config.formatter = Swat::UI::RspecSetup::Formatter unless rspec_config.is_a?(Hash)
      end

      def options
        @options
      end

      private

      def print_debug
        puts "SWAT UI version=#{Swat::UI::Version} initalized."
      end

    end
  end
end
