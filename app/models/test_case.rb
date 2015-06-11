class TestCase
  include Fire
  extend Converter

  class << self

    def query(namespace_opts)
      all_in_namespace(namespace_opts)
    end

    def add_to_namespace(namespace_opts, object)
      push_to(encrypt_testcase_namespace(namespace_opts), object)
    end

    def seconds_to_time(seconds)
      Time.at(seconds).utc.strftime("%H:%M:%S")
    end

    def collect(namespace_opts, rspec_example, extras)
      data = {
          description: rspec_example.description,
          full_description: rspec_example.full_description,
          file_path: rspec_example.file_path,
          location: rspec_example.location,
          exception: rspec_example.exception,
          status: rspec_example.metadata[:execution_result].status,
          started_at: rspec_example.metadata[:execution_result].started_at,
          run_time: seconds_to_time(rspec_example.metadata[:execution_result].run_time)
      }.merge!(extras)
      if rspec_example.respond_to?(:swat_extras)
        data.merge(swat_extras: rspec_example.swat_extras)
      end
      add_to_namespace(namespace_opts, data)
    end


    def all(namespace=nil)
      if namespace
        all_in_namespace(namespace)
      else
        response = super()
        response.map(&:values).flatten.map(&:values).flatten.map(&:values).flatten
      end
    end

    def all_in_namespace(namespace_opts)
      spaces = spaces_by(namespace_opts)
      spaces.map do |space|
        get_from(space).try(:values) || []
      end.flatten
    end

    def remove_by(namespace_opts)
      spaces_by(namespace_opts).each do |sp|
        delete_from(sp)
      end
    end

    private

    def spaces_by(opts)
      summary = Revision.summary

      namespace_opts = normalize_opts(opts)

      branches = affected(summary, namespace_opts, :branch)
      users = affected(summary, namespace_opts, :user)
      times = affected(summary, namespace_opts, :time)

      branches.map{|b|
        users.map{|u|
          times.map{|t|
            encrypt_testcase_namespace(branch: b, user: u, time: t)
          }
        }
      }.flatten.uniq
    end

    def affected(summary, opts, key)
      summary[key].select{|x| affected_value?(opts[key], x)  }.uniq
    end

    def encrypt_testcase_namespace(opts)
      time = str_to_date(opts[:time])
      [ opts[:branch], opts[:user], date_to_str(time) ]*Fire::LEVEL_SEPARATOR
    end

    def affected_value?(opts_value, summary_value)
      if opts_value.is_a?(Array)
        opts_value.empty? || opts_value.include?(summary_value)
      else
        opts_value ? summary_value == opts_value : true
      end
    end

    def normalize_opts(opts)
      namespace_opts = opts.each_with_object({}) do |(k, v), res|
        res[k.to_sym]  = v
      end

      namespace_opts[:time] = time_date_value(namespace_opts[:time]) if namespace_opts[:time]
      namespace_opts
    end


  end

end
