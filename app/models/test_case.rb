class TestCase < Fire::Model
  has_path_keys :branch, :user, :time, :thread_id

  class << self

    def collect(revision_opts, rspec_example, extras)
      data = {
          description: rspec_example.description,
          full_description: rspec_example.full_description,
          file_path: rspec_example.file_path,
          location: rspec_example.location,
          status: rspec_example.metadata[:execution_result].status,
          started_at: rspec_example.metadata[:execution_result].started_at,
          run_time: rspec_example.metadata[:execution_result].run_time
      }.merge!(revision_opts).merge!(extras)

      if rspec_example.exception
        data[:exception] = extract_exception(rspec_example)
      end

      if rspec_example.respond_to?(:swat_extras)
        data.merge!(swat_extras: rspec_example.swat_extras)
      end

      create(data)
    end

    private

    def extract_exception(rspec_example)
      trace = rspec_example.exception.backtrace
      if defined?(Rails)
        trace = ([ trace.first ] + trace.select{|x| x.include?(Rails.root.to_s) } + [ trace.last ]).uniq
      end
      {
          message: rspec_example.exception.message,
          backtrace: trace,
      }
    end

  end

end
