module Fire
  extend ActiveSupport::Concern

  module ClassMethods

    def all
      fire_client.get(collection).body.values
    end

    def push(attrs)
      fire_client.push collection, attrs
    end

    def collection
      self.to_s
    end

    def fire_client
      require 'firebase'
      @fb ||= Firebase::Client.new(Swat::UI.config.options[:firebase])
    end

  end

end
