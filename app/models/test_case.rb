class TestCase
  include Fire

  class  << self

    def query(opts)
      ns  = Namespace.all
      selected_ns = namespaces(ns, opts)

      return all if selected_ns == ns

      selected_ns.map do |n|
        all_in_namespace(Namespace.encrypt_namespace(n))
      end.flatten
    end

    def add_to_namespace(namespace_opts, object)
      push_to(Namespace.encrypt_namespace(namespace_opts), object)
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
      str_date_opt = opts[:revision].map{|d| Namespace.date_to_str(Namespace.str_to_date(d)) } rescue []

      ns.select!{|n| opts[:branch].include? n[:branch] } unless opts[:branch].blank?
      ns.select!{|n| opts[:user].include? n[:user] } unless opts[:user].blank?
      ns.select!{|n| str_date_opt.include? Namespace.date_to_str(n[:revision]) } unless opts[:revision].blank?

      ns
    end

  end

end
