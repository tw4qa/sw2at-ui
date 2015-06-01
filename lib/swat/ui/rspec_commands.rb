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
        })

        def initialize(conf_options, revision)
          @config = conf_options
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

        def thread_name(thread_opts, index)
          thread_opts[:name] || "Thread##{index+1}"
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
              ENV_VARS.db_env_number => index,
          })

          [ env_params, rake_command('db:create'), '&&', env_params, rake_command('db:migrate') ].join(' ')
        end

        def clean_command(thread_opts, index)
          env_params = build_params({
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
