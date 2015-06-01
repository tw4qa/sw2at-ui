module Swat
  module UI
    module RSpecCommands

      class CommandsBuilder
        require 'ostruct'

        attr_reader :config, :revision
        ENV_VARS = OpenStruct.new({
            revision: 'SWAT_CURRENT_REVISION',
            threads_count: 'SWAT_THREADS_COUNT',
            db_env_number: 'TEST_ENV_NUMBER',
            thread_id: 'SWAT_CURRENT_THREAD_ID',
            thread_name: 'SWAT_CURRENT_THREAD_NAME',
            rails_env: 'RAILS_ENV',
        })

        def initialize(conf_options, revision)
          @config = conf_options
          unless @config[:threads]
            @config[:threads] = [{ name: 'Full' }]
          end
          @revision = revision
        end

        def threads_count
          @config[:threads].count
        end

        def thread_scenarios
          res = []
          @config[:threads].each_with_index  do |th, index|
            res << thread_scenario(th, index)
          end
          res
        end

        def thread_scenario(thread_opts, index)
          {
              clean: clean_command(thread_opts, index),
              prepare: prepare_command(thread_opts, index),
              run: run_command(thread_opts, index),
          }
        end

        def full_thread_scenarios
          thread_scenarios.map do |ts|
            ts.map do |(action, command)|
              "##{action}\n#{command}"
            end.join "\n"
          end*"\n===================\n"
        end

        def thread_name(thread_opts, index)
          thread_opts[:name] || "Thread##{index+1}"
        end

        class << self
          def current_revision
            ENV[ENV_VARS.revision] ? Time.parse(ENV[ENV_VARS.revision]) : now
          end

          def current_threads_count
            ENV[ENV_VARS.threads_count] || 1
          end

          def current_thread_name
            ENV[ENV_VARS.thread_name]
          end

          def current_thread_id
            ENV[ENV_VARS.thread_id].to_i
          end

          def current_scenarios
            new(Swat::UI.config.options, current_revision).thread_scenarios
          end

          def now
            (Time.respond_to?(:now_without_mock_time) ? Time.now_without_mock_time : Time.now)
          end

        end

        private

        def run_command(thread_opts, index)
          env_params = build_params({
            ENV_VARS.db_env_number => index,
            ENV_VARS.revision => @revision,
            ENV_VARS.threads_count => threads_count,
            ENV_VARS.thread_id => index,
            ENV_VARS.thread_name => thread_name(thread_opts, index),
          })

          [ env_params, rspec_command(thread_opts) ].join(' ')
        end

        def prepare_command(thread_opts, index)
          env_params = build_params({
              ENV_VARS.rails_env => 'test',
              ENV_VARS.db_env_number => index,
          })

          [ env_params, rake_command('db:create'), '&&', env_params, rake_command('db:migrate') ].join(' ')
        end

        def clean_command(thread_opts, index)
          env_params = build_params({
              ENV_VARS.rails_env => 'test',
              ENV_VARS.db_env_number => index,
          })

          [ env_params, rake_command('db:drop') ].join(' ')
        end

        def build_params(params)
          params.to_a.map do |k, v|
            [ k, v ]*?=
          end.join(' ')
        end

        def rspec_command(thread_opts)
          [
              'rspec',
              tag_opts(thread_opts[:tags]),
              file_pattern_opts(thread_opts[:file_pattern]),
          ].compact.join ' '
        end

        def tag_opts(tags)
          return nil unless tags
          ([tags].flatten).map do |tag_name|
            [ '--tag', tag_name ]*' '
          end*' '
        end

        def file_pattern_opts(pattern)
          pattern
        end

        def rake_command(task)
          "rake #{task}"
        end

      end

    end
  end
end
