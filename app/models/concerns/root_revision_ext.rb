module RootRevisionExt
  extend ActiveSupport::Concern

  def extend_path_data(args)
    attrs = self.class.prepare_hash(args)
    if attrs[:main]
      self.class.all_path_keys.each do |k|
        attrs[k] = attrs[:main][k.to_s]
      end
    end
    attrs
  end

  module ClassMethods

    def stats
      all_revisions = all

      branches_stats = all_revisions.count_by_rule(&:branch)
      users_stats = all_revisions.count_by_rule(&:user)
      periods_stats = all_revisions.count_by_rule{|x| period(x.time) }

      branches = branches_stats.keys
      users = users_stats.keys
      periods = periods_stats.keys

      {
          branches: branches,
          users: users,
          periods: periods,
          stats: {
              branches: branches_stats,
              users: users_stats,
              periods: periods_stats,
          }
      }
    end

    def period(timestamp)
      Time.at(timestamp).strftime('%m/%d/%Y')
    end

  end

end