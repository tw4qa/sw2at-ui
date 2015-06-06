module Swat
  module UI
    module RspecSetup
      require 'swat/ui/stats_collector'
      require 'rspec'
      require 'rspec/core/formatters'
      require 'rspec/core/formatters/base_formatter'

      class Formatter < RSpec::Core::Formatters::BaseFormatter

        RSpec::Core::Formatters.register self, :example_started, :example_passed, :example_failed, :start, :stop

        def example_passed(notification)
          StatsCollector.new(notification.notification).collect_case if Swat::UI.config.options[:collect]
        end

        def example_failed(notification)
          StatsCollector.new(notification.notification).collect_case if Swat::UI.config.options[:collect]
        end

        def stop(notification)
          StatsCollector.new(notification).collect_thread if Swat::UI.config.options[:collect]
        end

        def start(notification)
          StatsCollector.new(notification).collect_thread_start if Swat::UI.config.options[:collect]
        end

        def example_started(notification); end
      end

      def init_ui(options = {})
      end

    end
  end
end
