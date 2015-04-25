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

    def remove_by &condition
      namespaces = all_with_fire_ids
      namespaces.select{|ns|
        condition.(decrypt_namespace(ns['value']))
      }.each do |ns|
        TestCase.delete(ns['value'])
        delete(ns[:fire_id])
      end
    end

    def remove_revision revision
      remove_by{ |ns| ns[:revision] == revision }
    end

    def remove_branch branch
      remove_by{ |ns| ns[:branch] == branch }
    end

    def remove_user user
      remove_by{ |ns| ns[:user] == user }
    end

    def encrypt_namespace(opts)
      revision = opts[:revision].is_a?(String) ? str_to_date(opts[:revision]) : opts[:revision]
      [ opts[:branch], date_to_str(revision), opts[:user] ]*SEPARATOR
    end

    def decrypt_namespace(name)
      b, r, u = name.split(SEPARATOR)
      { branch: b, revision: DateTime.strptime(r, DATE_MASK), user: u }
    end

    def date_to_str(revision)
      revision.strftime(DATE_MASK)
    end

    def str_to_date(str)
      DateTime.parse(str, DATE_MASK)
    end

    def reformat_date(str)
      Revision.date_to_str(Revision.str_to_date(str))
    end

  end

end