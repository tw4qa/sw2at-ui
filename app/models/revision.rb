class Revision
  include Fire
  extend BasicStatsCalculator
  extend Converter

  class << self
    MAIN_FOLDER = 'main'
    RESULTS_FOLDER = 'stats'
    THREADS_FOLDER = 'threads'

    def query_one(revision_opts)
      id = encrypt_namespace revision_opts
      revision = prepare_response(get_from(id))
      tests = test_cases(revision_opts).group_by{|t| t['thread_id'] }
      revision[:tests] = tests
      calculate_detailed_stats(revision)
      revision
    end

    def all
      resp = super()
      resp.map do |x|
        prepare_response(x)
      end
    end

    def test_cases(revision_opts)
      TestCase.all_in_namespace(revision_opts)
    end

    def add(opts)
      id = encrypt_namespace(opts)
      path = inner_folder(id)
      set_to(path, opts.merge(id: id))
    end

    def add_thread_results(namspace_opts, rspec_notification, extras)
      data = thread_stats(rspec_notification).merge(extras)
      id = encrypt_namespace(namspace_opts)
      path = inner_folder(id, RESULTS_FOLDER)
      push_to(path, data)
    end

    def add_revision_thread(namspace_opts, rspec_notification, extras)
      data = thread_begining(rspec_notification).merge(extras)
      id = encrypt_namespace(namspace_opts)
      path = inner_folder(id, THREADS_FOLDER)
      push_to(path, data)
    end

    def remove_by_time time
      TestCase.remove_by(time: time)
      remove_by{ |ns| ns[:time] == time }
    end

    def remove_branch branch
      TestCase.remove_by(branch: branch)
      remove_by{ |ns| ns[:branch] == branch }
    end

    def remove_user user
      TestCase.remove_by(user: user)
      remove_by{ |ns| ns[:user] == user }
    end

    def summary
      all_revisions = all
      [ :branch, :user, :time ].each_with_object({}) do |key, res|
        res[key] = all_revisions.map{|r| r[key] }
      end
    end

    private

    def remove_by &condition
      namespaces = all
      namespaces.select{|ns|
        condition.(ns)
      }.each do |ns|
        delete_from(inner_folder(encrypt_namespace(ns)))
      end
    end

    def thread_stats(rspec_notification)
      data = {
        total_examples: rspec_notification.examples.count,
        failed_examples: rspec_notification.failed_examples.count,
        pending_examples: rspec_notification.pending_examples.count,
        formatted_fails: rspec_notification.fully_formatted_failed_examples,
        total_runtime: rspec_notification.examples.map{|ex| ex.metadata[:execution_result].run_time }.inject(:+)
      }
    end

    def thread_begining(rspec_notification)
      data = {
          total_examples: rspec_notification.count,
      }
    end

    def inner_folder(encrypted_namespace, folder = MAIN_FOLDER)
      [ encrypted_namespace, folder ]*Fire::LEVEL_SEPARATOR
    end

    def prepare_response(resp)
      results = resp[RESULTS_FOLDER].values rescue nil
      threads = resp[THREADS_FOLDER].values rescue nil
      main = resp[MAIN_FOLDER]
      key = decrypt_namespace(main.delete('id'))
      res = key.merge!(results: results, threads: threads, threads_count: main['threads_count'])
      res[:name] = main['name'] if main['name']
      calculate_basic_stats(res)
      res
    end

  end

end
