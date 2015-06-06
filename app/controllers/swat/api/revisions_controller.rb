module Swat
  module Api
    class RevisionsController < Swat::ApplicationController
      def index
        render json: revisions
      end

      private

      def namespaces
        Revision.all
      end
    end
  end
end