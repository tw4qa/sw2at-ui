module Swat
  module UI
    module RspecSetup
      require 'swat/ui/stats_collector'

      class Formatter
        require 'rspec'
        require 'rspec/core/formatters'

        RSpec::Core::Formatters.register self, :example_started, :example_passed, :example_failed, :start, :stop

        def initialize(output)
          @output = output
        end

        def example_started(notification)
          puts 'example_started'
          puts notification.inspect
        end

        def example_passed(notification)
          puts 'example_passed'
          puts notification.inspect
          binding.pry if $deb
        end

        def example_failed(notification)
          puts 'example_failed'
          puts notification.inspect
          binding.pry if $deb
        end

        def start(notification)
          puts 'start'
          puts notification.inspect
        end

        def stop(notification)
          puts 'stop'
          puts notification.inspect
          binding.pry if $deb
        end
      end

      def init_ui(options = {})
        before(:each) do |example|
          @sw_test_started_at = StatsCollector.now
        end

        after(:each) do |example|
          time = StatsCollector.now - @sw_test_started_at rescue 0
          StatsCollector.new(example, time).collect if Swat::UI.config.options[:collect]
        end

      end

    end
  end
end
