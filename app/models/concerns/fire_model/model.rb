module Fire
  require 'ostruct'
  require 'firebase'

  class Model < OpenStruct

    LEVEL_SEPARATOR = ?/

    cattr_accessor :firebase_path
    cattr_accessor :global_fire_collection, :global_path_keys

    def initialize(data={})
      unless data[:id]
        data[:id] = self.class.next_id
      end
      super(data)
    end

    def collection_name
      self.class.collection_name
    end

    def path_values
      self.class.path_keys.map{|pk|
        path_value = send(pk)
        raise PathValueMissingError.new(pk) if path_value.to_s.empty?
        path_value.to_s.parameterize
      }
    end

    def path
      ([ collection_name ] + path_values) * LEVEL_SEPARATOR
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
        own_path_keys = (self.global_path_keys || { })[default_collection_name] ||= []
        own_path_keys + default_path_keys
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

  end
end