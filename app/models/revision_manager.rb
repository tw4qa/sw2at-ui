class RevisionManager

  class << self

    def fetch_revision(all_params)
      params = prepare_fetch_params(all_params)
      revision = Revision::Root.take(params)
      tests = TestCase.query(params)
      construct(revision, tests)
    end

    def fetch_revisions
      Revision::Root.all.map do |rev|
        construct(rev, [])
      end
    end

    private

    def construct(revision, tests)
      thread_values = (revision.threads || {}).values
      thread_values.each do |th|
        th[:tests] = tests.select{|test| test.thread_id.to_s == th[:thread_id].to_s }.map(&:data)
      end
      revision.main.merge(threads: thread_values )
    end

    def prepare_fetch_params(all_params)
      res = {
          branch: all_params[:branch],
          user: all_params[:user],
          time: all_params[:time],
      }
      res[:time] = res[:time].to_i if res[:time]
      res
    end

  end



end