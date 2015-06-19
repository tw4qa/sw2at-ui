module Swat
  module UI
    module RspecSetup
      class StatsCollector
        require 'swat/ui/rspec_commands'

        def initialize
          @revision = Revision.add(current_namespace.merge(threads_count: current_threads_count, name: current_revision_name))
        end

        def collect_case(notification)
          TestCase.collect(current_namespace, notification, thread_id: current_thread_id)
        end

        def collect_started_thread(notification)
          @revision.collect_started_thread(notification,
               thread_id: current_thread_id,
               thread_name: current_thread_name
          )
        end

        def collect_ended_thread(notification)
          @revision.collect_ended_thread(notification,
            thread_id: current_thread_id,
            thread_name: current_thread_name,
          )
        end

        def current_namespace
          {
              branch: current_branch,
              user: user,
              time: current_revision_time,
              name: name,
              threads_count: current_threads_count,
          }
        end

        private

        def collection_available?
          branch_valid?
        end

        def branch_valid?
          Swat::UI.config.options[:collect_branch].nil? ||
              Swat::UI.config.options[:collect_branch] == current_branch
        end

        def current_branch
          @cb ||= RSpecCommands::CommandsBuilder.current_branch
        rescue
          nil
        end

        def user
          @u ||= RSpecCommands::CommandsBuilder.current_user
        end

        def name
          @name ||= RSpecCommands::CommandsBuilder.current_revision_name
        end

        def current_revision_time
          RSpecCommands::CommandsBuilder.current_revision_time
        end

        def current_revision_name
          RSpecCommands::CommandsBuilder.current_revision_name
        end

        def current_threads_count
          RSpecCommands::CommandsBuilder.current_threads_count
        end

        def current_thread_id
          RSpecCommands::CommandsBuilder.current_thread_id
        end

        def current_thread_name
          RSpecCommands::CommandsBuilder.current_thread_name
        end

      end

    end
  end
end