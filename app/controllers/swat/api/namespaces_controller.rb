module Swat
  module Api
    class NamespacesController < Swat::ApplicationController
      def index
        render json: namespaces
      end

      private

      def namespaces
        Revision.all
      end
    end
  end
end