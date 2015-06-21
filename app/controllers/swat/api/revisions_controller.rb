module Swat
  module Api
    class RevisionsController < Swat::ApplicationController
      before_filter :parse_revision_options, only: :show


      def index
        render json: revisions
      end

      def show
        render json: RevisionManager.revision_json(@options)
      end

      private

      def revisions
        RevisionManager.revision_jsons
      end

      def parse_revision_options
        @options = params[:json_params] ? HashWithIndifferentAccess[JSON.parse(params[:json_params])] : params
      end

    end
  end
end