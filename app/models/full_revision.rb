require Swat::Engine.root.join 'app/models/revision_status_calculator'

class FullRevision

  class << self

    def fetch(all_params, update_status=true)
      params = prepare_fetch_params(all_params)
      revision = Revision::Root.take(params)
      tests = TestCase.query(params)
      merge(revision, tests, update_status)
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

    def merge(revision, tests, update_status=false)
      revision.nested_threads.each do |th|
        th.tests = tests.select{|test| test.thread_id.to_s == th.thread_id.to_s }.map{|test| test.thread_name = th.thread_name; test }
      end

      assign_status(revision, update_status)
      revision
    end

    def to_json(revision)
      main = revision.nested_main.data
      main[:threads] = revision.nested_threads.map do |th|
        data = clean_keys(th.data)
        data[:tests] = th.tests.map(&:data)
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

    def assign_status(revision, update)
      if update
        update_status!(revision)
      else
        RevisionStatusCalulator.new(revision).set_status
      end
    end

    def update_status!(revision)
      current_status = revision.nested_status.data.clone

      return if current_status[:completed]

      new_status = RevisionStatusCalulator.new(revision).set_status
      return if new_status[:passed] && current_status[:failed]

      revision.save
    end

  end

end