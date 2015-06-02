module Fire
  extend ActiveSupport::Concern

  LEVEL_SEPARATOR = ?/
  ROOT = ?/

  module ClassMethods

    def all
      body = get
      body ? body.values : []
    end

    # GET ---

    def get
      fire_client.get(collection).body
    end

    def get_from(namespace)
      fire_client.get(build_namespace(namespace)).body
    end

    # PUSH ---

    def push(object)
      fire_client.push collection, object
    end

    def push_to(namespace, object)
      fire_client.push(build_namespace(namespace), object)
    end

    # DELETE ---

    def delete(element)
      fire_client.delete([ collection, element ]*LEVEL_SEPARATOR)
    end

    def delete_from(namespace, element=nil)
      fire_client.delete([ build_namespace(namespace), element ].compact*LEVEL_SEPARATOR)
    end

    # SET ---

    def set(object)
      fire_client.set collection, object
    end

    def set_to(namespace, object)
      fire_client.set(build_namespace(namespace), object)
    end

    # Other

    def path_empty?(full_path)
      fire_client.get(full_path).body.nil?
    end

    def collection
      self.to_s
    end

    def build_namespace(namespace)
      [collection, namespace]*LEVEL_SEPARATOR
    end

    def fire_client
      require 'firebase'
      @fb ||= Firebase::Client.new(Swat::UI.config.options[:firebase])
    end

    def drop!
      fire_client.delete(root)
    end

    def root
      ROOT
    end

  end

  extend ClassMethods
end
