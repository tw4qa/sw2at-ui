class Revision
  include Fire
  SEPARATOR = ':::'
  DATE_MASK = '%m-%d-%Y_%I-%M'

  class  << self

    def all
      resp = super()
      resp.map do |ns|
        decrypt_namespace(ns['value'])
      end
    end

    def add(opts)
      push(value: encrypt_namespace(opts))
    end

    def remove_by_time time
      TestCase.remove_by(time: time)
      remove_by{ |ns| ns[:time] == time }
    end

    def remove_branch branch
      TestCase.remove_by(branch: branch)
      remove_by{ |ns| ns[:branch] == branch }
    end

    def remove_user user
      TestCase.remove_by(user: user)
      remove_by{ |ns| ns[:user] == user }
    end

    def encrypt_namespace(opts)
      time = opts[:time].is_a?(String) ? str_to_date(opts[:time]) : opts[:time]
      [ opts[:branch], date_to_str(time), opts[:user] ]*SEPARATOR
    end

    def decrypt_namespace(name)
      b, r, u = name.split(SEPARATOR)
      { branch: b, time: DateTime.strptime(r, DATE_MASK), user: u }
    end

    def date_to_str(time)
      time.strftime(DATE_MASK)
    end

    def str_to_date(str)
      DateTime.parse(str, DATE_MASK)
    end

    def reformat_date(str)
      Revision.date_to_str(Revision.str_to_date(str))
    end

    def summary
      all_revisions = all
      [:branch, :user, :time].each_with_object({}) do |key, res|
        res[key] = all_revisions.map{|r| r[key] }
      end
    end

    private

    def remove_by &condition
      namespaces = all_with_fire_ids
      namespaces.select{|ns|
        condition.(decrypt_namespace(ns['value']))
      }.each do |ns|
        delete(ns[:fire_id])
      end
    end

  end

end