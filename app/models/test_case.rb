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
        fire_client.get(full_collection(space)).body.values
      end.flatten
    end

    def remove_by(namespace_opts)
      spaces_by(namespace_opts).each do |sp|
        fire_client.delete(full_collection(sp))
      end
    end

    private

    def spaces_by(namespace_opts)
      summary = Revision.summary

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
      summary[key].select{|x| opts[key] ? x==opts[key] : true  }.uniq
    end

    def encrypt_testcase_namespace(opts)
      time = opts[:time].is_a?(String) ? str_to_date(opts[:time]) : opts[:time]
      [ opts[:branch], opts[:user], Revision.date_to_str(time) ]*?/
    end

  end

end
