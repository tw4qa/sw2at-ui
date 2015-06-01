module Swat
  module UI
    module RspecSetup
      class StatsCollector
        require 'swat/ui/rspec_commands'

        def initialize(example)
          @example = example
        end

        def collect_case
          return unless branch_valid?
          TestCase.collect(current_namespace, @example, current_namespace.merge(thread_id: current_thread_id))
        rescue Exception => ex
          puts ex.message
        end

        def collect_thread
          return unless branch_valid?
          Revision.add_thread_stats(current_namespace, @example,
            thread_id: current_thread_id,
            thread_name: current_thread_name,
          )
        rescue Exception => ex
          puts ex.message
        end

        def self.now
          (Time.respond_to?(:now_without_mock_time) ? Time.now_without_mock_time : Time.now)
        end

        def current_namespace
          {
              branch: current_branch,
              user: user,
              time: time,
              threads_count: current_threads_count,
          }
        end

        private

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

        def time
          unless $current_revision
            $current_revision = current_revision
            Revision.add(
                branch: current_branch,
                user: user,
                time: $current_revision,
                threads_count: current_threads_count,
            )
          end
          $current_revision
        end

        def current_revision
          ENV['SWAT_CURRENT_REVISION'] ? Time.parse(ENV['SWAT_CURRENT_REVISION']) : self.class.now
        end

        def current_threads_count
          ENV['SWAT_CURRENT_THREADS_COUNT'] ? ENV['SWAT_CURRENT_THREADS_COUNT'].to_i : 1
        end

        def current_thread_id
          ENV['SWAT_CURRENT_THREAD_ID'].to_i
        end

        def current_thread_name
          ENV['SWAT_CURRENT_THREAD_NAME'] || "Thread##{current_thread_id}"
        end

      end

    end
  end
end