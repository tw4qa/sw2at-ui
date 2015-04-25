class TestCase
  include Fire

  class << self

    def query(opts)
      all_cases = all
      str_date_opt = opts[:time].map{|d| Revision.reformat_date(d) } rescue []

      all_cases.select!{|n| opts[:branch].include? n['branch'] } unless opts[:branch].blank?
      all_cases.select!{|n| opts[:user].include? n['user'] } unless opts[:user].blank?
      all_cases.select!{|n| str_date_opt.include? Revision.reformat_date(n['time']) } unless opts[:time].blank?

      all_cases
    end

    def add_to_namespace(namespace_opts, object)
      push_to(Revision.encrypt_namespace(namespace_opts), object)
    end

    def all(namespace=nil)
      if namespace
        all_in_namespace(namespace)
      else
        super().map(&:values).flatten(1)
      end
    end

    def all_in_namespace(namespace)
      fire_client.get(build_namespace(namespace)).body.values
    end

    def namespaces(ns, opts)
      str_date_opt = opts[:time].map{|d| Revision.date_to_str(Revision.str_to_date(d)) } rescue []

      ns.select!{|n| opts[:branch].include? n[:branch] } unless opts[:branch].blank?
      ns.select!{|n| opts[:user].include? n[:user] } unless opts[:user].blank?
      ns.select!{|n| str_date_opt.include? Revision.date_to_str(n[:time]) } unless opts[:time].blank?

      ns
    end

  end

end
