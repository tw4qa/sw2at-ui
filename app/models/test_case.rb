class TestCase
  include Fire

  class << self

    def query(namespace_opts)
      all_in_namespace(namespace_opts)
    end

    def add_to_namespace(namespace_opts, object)
      push_to(encrypt_testcase_namespace(namespace_opts), object)
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
        fire_client.get(full_collection(space)).body.try(:values) || []
      end.flatten
    end

    def remove_by(namespace_opts)
      spaces_by(namespace_opts).each do |sp|
        fire_client.delete(full_collection(sp))
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

    def full_collection(space)
       [ collection, space ]*?/
    end

    def affected(summary, opts, key)
      summary[key].select{|x| affected_value?(opts[key], x)  }.uniq
    end

    def encrypt_testcase_namespace(opts)
      time = opts[:time].is_a?(String) ? str_to_date(opts[:time]) : opts[:time]
      [ opts[:branch], opts[:user], Revision.date_to_str(time) ]*?/
    end

    def affected_value?(opts_value, summary_value)
      if opts_value.is_a?(Array)
        opts_value ? opts_value.include?(summary_value) : true
      else
        opts_value ? summary_value == opts_value : true
      end
    end

    def time_value_str(time_value)
      if time_value.is_a?(Array)
        time_value.map{|tv| tv.is_a?(Date) ? Revision.date_to_str(tv) : tv }
      else
        time_value.is_a?(Date) ? Revision.date_to_str(time_value) : time_value
      end
    end

    def time_date_value(time_value)
      if time_value.is_a?(Array)
        time_value.map{|tv| tv.is_a?(String) ? Revision.str_to_date(tv) : tv }
      else
        time_value.is_a?(String) ? Revision.str_to_date(time_value) : time_value
      end
    end

    def symbol_value(time_value)
      if time_value.is_a?(Array)
        time_value.map &:to_sym
      else
        time_value.to_sym
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
