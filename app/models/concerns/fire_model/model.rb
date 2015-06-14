module Fire

  require 'ostruct'
  class Model < OpenStruct
    cattr_accessor :fire_collection

    def collection_name
      self.class.collection_name
    end

    class << self

      def collection_name
        (fire_collection && fire_collection[default_collection_name]) || default_collection_name
      end

      def in_collection(name)
        self.fire_collection ||= {}
        self.fire_collection[default_collection_name]  = name
      end

      def next_id
        rand(36**8).to_s(36)
      end

      private

      def default_collection_name
        name.demodulize
      end

    end

  end
end