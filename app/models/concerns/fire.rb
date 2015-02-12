module Fire
  extend ActiveSupport::Concern

  module ClassMethods

    def all
      body = fire_client.get(collection).body
      body ? body.values : []
    end

    def push(attrs)
      fire_client.push collection, attrs
    end

    def push_to(namespace, attrs)
      fire_client.push(build_namespace(namespace), attrs)
    end

    def collection
      self.to_s
    end

    def build_namespace(namespace)
      [collection, namespace]*'/'
    end

    def fire_client
      require 'firebase'
      @fb ||= Firebase::Client.new(Swat::UI.config.options[:firebase])
    end

  end

end
