module Fire
  extend ActiveSupport::Concern

  LEVEL_SEPARATOR = ?/
  ROOT = ?/

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

    def push(object)
      fire_client.push collection, object
    end

    def path_empty?(full_path)
      fire_client.get(full_path).body.nil?
    end

    def push_to(namespace, object)
      fire_client.push(build_namespace(namespace), object)
    end

    def collection
      self.to_s
    end

    def delete(element)
      fire_client.delete([ collection, element ]*LEVEL_SEPARATOR)
    end

    def build_namespace(namespace)
      [collection, namespace]*LEVEL_SEPARATOR
    end

    def fire_client
      require 'firebase'
      @fb ||= Firebase::Client.new(Swat::UI.config.options[:firebase])
    end

    def drop!
      fire_client.delete(ROOT)
    end

  end

  extend ClassMethods
end
