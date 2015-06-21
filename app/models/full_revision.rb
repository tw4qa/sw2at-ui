class FullRevision

  class << self

    def fetch(all_params)
      params = prepare_fetch_params(all_params)
      revision = Revision::Root.take(params)
      tests = TestCase.query(params)
      merge(revision, tests)
    end

    def fetch_all
      Revision::Root.all.map do |rev|
        merge(rev, [])
      end
    end

    def revision_json(all_params)
      to_json(fetch(all_params))
    end

    def revisions_json
      fetch_all.map do |rev|
        to_json(rev)
      end
    end

    private

    def merge(revision, tests)
      revision.nested_threads.each do |th|
        th.tests = tests.select{|test| test.thread_id.to_s == th.thread_id.to_s }
      end

      RevisionStatusCalulator.new.set_status(revision)
      revision
    end

    def to_json(revision)
      main = revision.nested_main.data
      main[:threads] = revision.nested_threads.map do |th|
        data = clean_keys(th.data)
        data[:tests].map!{|t| t.data }
        data
      end
      main[:status] = clean_keys(revision.nested_status.data)
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

    def clean_keys(original_hash, keys=[:branch, :user, :time, :id])
      keys.each{|k| original_hash.delete(k)}
      original_hash
    end

  end



end