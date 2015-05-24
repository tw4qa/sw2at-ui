module Swat
  module UI
    require 'swat/ui/rspec_setup'

    class Config

      def initialize(rspec_config, opts = {})
        print_debug if ENV['SWAT_DBG']
        @options = opts
        rspec_config.extend RspecSetup
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
