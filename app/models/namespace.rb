class Namespace
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
      Namespace.date_to_str(Namespace.str_to_date(str))
    end

  end

end