module Swat
  module UI
    module RspecSetup

      def init_ui(options = {})
        before(:each) do |example|
          @sw_test_started_at = (Time.respond_to?(:now_without_mock_time) ? Time.now_without_mock_time : Time.now)
        end

        after(:each) do |example|
          taken =  (Time.respond_to?(:now_without_mock_time) ? Time.now_without_mock_time : Time.now) - @sw_test_started_at
          puts "'#{example.description}' taken #{Time.at(taken).strftime('%M:%S')}"
        end

      end

    end
  end
end
