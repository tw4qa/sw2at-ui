module Fire
  extend ActiveSupport::Concern

  module ClassMethods

    def all
      body = get
      body ? body.values : []
    end

    def all_with_fire_ids
      body = get
      res = []
      (body||{}).each do |id, v|
        res << v.merge(fire_id: id)
      end
      res
    end

    def get
      fire_client.get(collection).body
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

    def delete(element)
      fire_client.delete([ collection, element ]*'/')
    end

    def build_namespace(namespace)
      [collection, namespace]*'/'
    end

    def fire_client
      require 'firebase'
      @fb ||= Firebase::Client.new(Swat::UI.config.options[:firebase])
    end

    def drop!
      fire_client.delete(?/)
    end

  end

  extend ClassMethods
end
