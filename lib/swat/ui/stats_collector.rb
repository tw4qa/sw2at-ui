module Swat
  module UI
    module RspecSetup
      class StatsCollector
        require 'swat/ui/rspec_commands'

        def initialize(notification)
          @notification = notification
        end

        def collect_case
          return unless collection_available?
          TestCase.collect(current_namespace, @notification, current_namespace.merge(thread_id: current_thread_id))
        rescue Exception => ex
          puts ex.message
        end

        def collect_thread
          return unless collection_available?
          Revision.add_thread_results(current_namespace, @notification,
            thread_id: current_thread_id,
            thread_name: current_thread_name,
          )
        rescue Exception => ex
          puts ex.message
        end

        def collect_thread_start
          return unless collection_available?
          Revision.add_revision_thread(current_namespace, @notification,
            thread_id: current_thread_id,
            thread_name: current_thread_name,
          )
        rescue Exception => ex
          puts ex.message
        end

        def current_namespace
          {
              branch: current_branch,
              user: user,
              time: time,
              name: name,
              threads_count: current_threads_count,
          }
        end

        private

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

        def collection_available?
          branch_valid?
        end

        def branch_valid?
          Swat::UI.config.options[:collect_branch].nil? ||
              Swat::UI.config.options[:collect_branch] == current_branch
        end

        def time
          unless $current_revision
            $current_revision = current_revision
            Revision.add(current_namespace.merge(threads_count: current_threads_count))
          end
          $current_revision
        end

        def current_revision
          RSpecCommands::CommandsBuilder.current_revision_time
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