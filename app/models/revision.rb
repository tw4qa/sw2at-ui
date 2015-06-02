class Revision
  include Fire
  extend Converter

  class << self
    MAIN_FOLDER = 'main'
    STATS_FOLDER = 'stats'

    def all
      resp = super()
      resp.map do |x|
        stats = x[STATS_FOLDER].values rescue nil
        decrypt_namespace(x[MAIN_FOLDER]['id']).merge!(stats: stats)
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

    def add_thread_stats(namspace_opts, rspec_notification, extras)
      data = thread_stats(rspec_notification).merge(extras)
      id = encrypt_namespace(namspace_opts)
      path = inner_folder(id, STATS_FOLDER)
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
        formatted_fails: rspec_notification.fully_formatted_failed_examples,
        total_runtime: rspec_notification.examples.map{|ex| ex.metadata[:execution_result].run_time }.inject(:+)
      }
    end

    def inner_folder(encrypted_namespace, folder = MAIN_FOLDER)
      [ encrypted_namespace, folder ]*Fire::LEVEL_SEPARATOR
    end

  end

end
