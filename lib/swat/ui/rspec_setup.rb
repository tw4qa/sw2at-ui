module Swat
  module UI
    module RspecSetup
      class StatsCollector

        def initialize(example)
          @example = example
        end

        def collect
          return unless branch_valid?
          data = {
            branch: current_branch,
            user: user,
            decription: @example.description,
            full_decription: @example.full_description,               
            file_path: @example.file_path,
            location: @example.location,
            status: @example.execution_result.status,
            run_time: @example.execution_result.run_time,           
          }
          fire_client.push(:test_cases_stats, data)
        rescue Exception => ex
          puts ex.message
        end

        def self.now
          (Time.respond_to?(:now_without_mock_time) ? Time.now_without_mock_time : Time.now)
        end

        private

        def fire_client
          require 'firebase'
          @fb ||= Firebase::Client.new(Swat::UI.config.options[:firebase])
        end

        def current_branch
          @cb ||= `git branch | grep '\''*'\'' | awk '\''{print $2}'\''`.gsub("\n",'')
        rescue
          nil
        end

        def user
          @u ||= `whoami`.gsub("\n",'')
        end

        def branch_valid?
          Swat::UI.config.options[:collect_branch].nil? ||
            Swat::UI.config.options[:collect_branch] == current_branch
        end

      end


      def init_ui(options = {})
        before(:each) do |example|
          @sw_test_started_at = StatsCollector.now
        end

        after(:each) do |example|
          StatsCollector.new(example).collect if Swat::UI.config.options[:collect]
          #puts "'#{example.description}' taken #{Time.at(taken).strftime('%M:%S')}"
        end

      end

    end
  end
end
