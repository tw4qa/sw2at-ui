module Swat
  module Api
    class RevisionsController < Swat::ApplicationController
      before_filter :parse_revision_options, only: :show


      def index
        render json: revisions
      end

      def show
        render json: Revision.query_one(@options)
      end

      private

      def revisions
        Revision.all
      end

      def parse_revision_options
        @options = params[:json_params] ? HashWithIndifferentAccess[JSON.parse(params[:json_params])] : params
      end

    end
  end
end