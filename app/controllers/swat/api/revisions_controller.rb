module Swat
  module Api
    class RevisionsController < Swat::ApplicationController

      def index
        render json: revisions
      end

      def show
        opts = HashWithIndifferentAccess[JSON.parse(params[:options])]
        revision = Revision.query_one(opts)
        render json: revision
      end

      private

      def revisions
        Revision.all
      end
    end
  end
end