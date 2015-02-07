module Swat
  module UI
    module RspecSetup
      class StatsCollector

        def collect(example, time)
          data = example.metadata
          data[:taken] = time
          fire_client.push(:test_cases_stats, data)
        end

        private

        def fire_client
          require 'firebase'
          Firebase::Client.new(Swat::UI.config.options[:firebase])
        end

        def current_branch
          `git branch | grep '\''*'\'' | awk '\''{print $2}'\''`.gsub("\n",'')
        rescue
          nil
        end
      end


      def init_ui(options = {})
        before(:each) do |example|
          @sw_test_started_at = (Time.respond_to?(:now_without_mock_time) ? Time.now_without_mock_time : Time.now)
        end

        after(:each) do |example|
          taken =  (Time.respond_to?(:now_without_mock_time) ? Time.now_without_mock_time : Time.now) - @sw_test_started_at
          StatsCollector.new.collect(example, taken) if Swat::UI.config.options[:collect]
          #puts "'#{example.description}' taken #{Time.at(taken).strftime('%M:%S')}"
        end

      end

    end
  end
end
