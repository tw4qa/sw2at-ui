module Swat
  module UI
    module RspecSetup
      require 'swat/ui/stats_collector'
      require 'rspec'
      require 'rspec/core/formatters'
      require 'rspec/core/formatters/base_formatter'

      class Formatter < RSpec::Core::Formatters::BaseFormatter

        RSpec::Core::Formatters.register self, :example_started, :example_passed, :example_failed, :start, :stop

        def initialize(arg)
          super arg
          @stats_collector = StatsCollector.new
        end

        def example_passed(notification)
          @stats_collector.collect_case(notification.example)
        end

        def example_failed(notification)
          @stats_collector.collect_case(notification.example)
        end

        def stop(notification)
          @stats_collector.collect_ended_thread(notification)
        end

        def start(notification)
          @stats_collector.collect_started_thread(notification)
        end

        def example_started(notification); end
      end

      def init_ui(options = {})
      end

    end
  end
end
