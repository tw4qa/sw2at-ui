module Fire
  require 'ostruct'
  require 'firebase'

  class Model < OpenStruct

    LEVEL_SEPARATOR = ?/

    cattr_accessor :firebase_path
    cattr_accessor :global_fire_collection, :global_path_keys

    def initialize(attrs={})
      data = HashWithIndifferentAccess[attrs]
      data[:id] ||= self.class.next_id
      super(data)
    end

    def collection_name
      self.class.collection_name
    end

    def path_values
      self.class.path_keys.map{|pk|
        path_value = send(pk)
        raise PathValueMissingError.new(pk) if path_value.to_s.empty?
        path_value_param(path_value)
      }
    end

    def save
      self.class.connection.set(path, self.to_h)
    end

    def delete
      self.class.connection.delete(path)
    end

    def path
      ([ collection_name ] + path_values) * LEVEL_SEPARATOR
    end

    def ==(model_object)
      self.to_h == model_object.to_h
    end


    class << self

      # Klass Setters

      def in_collection(name)
        self.global_fire_collection ||= {}
        self.global_fire_collection[default_collection_name]  = name
      end

      def has_path_keys(*keys)
        self.global_path_keys ||= {}
        self.global_path_keys[default_collection_name]=keys
      end

      # Klass Accessors

      def collection_name
        custom_name = (global_fire_collection && global_fire_collection[default_collection_name])
        custom_name || default_collection_name
      end

      def connection
        firebase_path ? Firebase::Client.new(firebase_path) : (raise NoFirebasePathSetError.new)
      end

      def path_keys
        own_path_keys + default_path_keys
      end

      def own_path_keys
        (self.global_path_keys || { })[default_collection_name] ||= []
      end

      # Querying

      def all
        response = connection.get(collection_name).body
        return [] if response.nil?
        result = response.values

        own_path_keys.each do
          result = result.map(&:values).flatten.compact
        end

        result.map{|data| new(data) }
      end

      def take(path_data)
        path_object = new(path_data)
        loaded_data = connection.get(path_object.path).body
        loaded_data.nil? ? nil : new(loaded_data)
      end

      def create(object)
        model = new(object)
        model.save
        model
      end

      # Helpers

      def next_id
        rand(36**8).to_s(36)
      end

      private

      def default_collection_name
        name.demodulize
      end

      def default_path_keys
        [ :id ]
      end

    end

    class FireModelError < StandardError; end

    class NoFirebasePathSetError < FireModelError
      def initialize
        super 'Firebase path is not set!'
      end
    end

    class PathValueMissingError < FireModelError
      def initialize(key)
        super "Required path key '#{ key }' is not set!"
      end
    end

    private

    def path_value_param(raw_value)
      return raw_value.to_s+?_ if raw_value.is_a?(Numeric)
      raw_value.to_s.parameterize
    end

  end
end