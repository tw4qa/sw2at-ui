module Swat
  module UI
    module RspecSetup
      class StatsCollector

        def initialize(example, time)
          @example, @time = example, time
        end

        def collect
          return unless branch_valid?
          TestCase.collect(current_namespace, @time, @example)
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
                time: $current_revision
            )
          end
          $current_revision
        end

        def current_revision
          ENV['SWAT_CURRENT_REVISION'] ? Time.parse(ENV['SWAT_CURRENT_REVISION']) : self.class.now
        end
      end

    end
  end
end