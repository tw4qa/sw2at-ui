module Swat
  module UI
    module RspecSetup
      class StatsCollector

        def initialize(example, time)
          @example, @time = example, time
        end

        def collect
          fork do
            return unless branch_valid?
            data = @example.metadata
            data[:taken] = @time
            data[:branch] = current_branch
            data[:user] = user
            fire_client.push(:test_cases_stats, data)
          end
        end

        private

        def fire_client
          require 'firebase'
          Firebase::Client.new(Swat::UI.config.options[:firebase])
        end

        def current_branch
          @cb ||= `git branch | grep '\''*'\'' | awk '\''{print $2}'\''`.gsub("\n",'')
        rescue
          nil
        end

        def user
          `whoami`.gsub("\n",'')
        end

        def branch_valid?
          Swat::UI.config.options[:collect_branch] == current_branch
        end
      end


      def init_ui(options = {})
        before(:each) do |example|
          @sw_test_started_at = (Time.respond_to?(:now_without_mock_time) ? Time.now_without_mock_time : Time.now)
        end

        after(:each) do |example|
          taken =  (Time.respond_to?(:now_without_mock_time) ? Time.now_without_mock_time : Time.now) - @sw_test_started_at
          StatsCollector.new(example, taken).collect if Swat::UI.config.options[:collect]
          #puts "'#{example.description}' taken #{Time.at(taken).strftime('%M:%S')}"
        end

      end

    end
  end
end
