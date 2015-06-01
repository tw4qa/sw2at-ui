module Swat
  module UI
    module RspecSetup
      require 'swat/ui/stats_collector'
      require 'rspec'
      require 'rspec/core/formatters'
      require 'rspec/core/formatters/base_text_formatter'

      class Formatter < RSpec::Core::Formatters::BaseTextFormatter


        RSpec::Core::Formatters.register self, :example_started, :example_passed, :example_failed, :start, :stop


        def example_started(notification)
          super
        end

        def example_passed(notification)
          super
          binding.pry if $deb
        end

        def example_failed(notification)
          super
          binding.pry if $deb
        end

        def start(notification)
          super
        end

        def stop(notification)
          super
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
