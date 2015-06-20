module Swat
  module Api
    class RevisionsController < Swat::ApplicationController
      before_filter :parse_revision_options, only: :show


      def index
        render json: revisions
      end

      def show
        render json: RevisionManager.fetch_revision(@options)
      end

      private

      def revisions
        RevisionManager.fetch_revisions
      end

      def parse_revision_options
        @options = params[:json_params] ? HashWithIndifferentAccess[JSON.parse(params[:json_params])] : params
        if @options[:time]
          @options[:time] = @options[:time].to_i
        end
      end

    end
  end
end