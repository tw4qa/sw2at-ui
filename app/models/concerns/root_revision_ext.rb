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

      branches_stats = all_revisions.count_by_rule{|x| x.branch }
      users_stats = all_revisions.count_by_rule{|x| x.user }
      periods_stats = all_revisions.count_by_rule{|x| Time.at(x.time).strftime('%m/%d/%Y') }

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

  end

end