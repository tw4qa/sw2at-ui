class RevisionManager

  class << self

    def fetch_revision(all_params)
      params = prepare_fetch_params(all_params)
      revision = Revision::Root.take(params)
      tests = TestCase.query(params)
      merge(revision, tests)
    end

    def fetch_revisions
      Revision::Root.all.map do |rev|
        merge(rev, [])
      end
    end

    def revision_json(all_params)
      to_json(fetch_revision(all_params))
    end

    def revisions_json
      fetch_revisions.map do |rev|
        to_json(rev)
      end
    end

    private

    def merge(revision, tests)
      revision.nested_threads.each do |th|
        th.tests = tests.select{|test| test.thread_id.to_s == th.thread_id.to_s }
      end
      revision
    end

    def to_json(revision)
      main = revision.nested_main.data
      main[:threads] = revision.nested_threads.map do |th|
        data = th.data
        [:branch, :user, :time].each{|k| data.delete(k)}
        data[:tests].map!{|t| t.data }
        data
      end
      main
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