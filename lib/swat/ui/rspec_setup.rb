module Swat
  module UI
    module RspecSetup
      require 'swat/ui/stats_collector'


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
