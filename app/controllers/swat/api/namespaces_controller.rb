module Swat
  module Api
    class NamespacesController < Swat::ApplicationController
      def index
        render json: namespaces
      end

      private

      def namespaces
        Namespace.all
      end
    end
  end
end