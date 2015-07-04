module Swat
  module Api
    class RevisionsController < Swat::ApplicationController
      before_filter :parse_revision_options, only: [ :show, :set_name ]


      def index
        render json: revisions
      end

      def show
        render json: FullRevision.revision_json(@options)
      end

      def set_name
        revision = Revision.take(@options)
        revision.update_field(:name, params[:name])
        render json: { success: true }
      end

      private

      def revisions
        FullRevision.revisions_json
      end

      def parse_revision_options
        @options = params[:json_params] ? HashWithIndifferentAccess[JSON.parse(params[:json_params])] : params
        @options[:time] = @options[:time].to_i if @options[:time]
        @options[:branch] = URI.unescape(@options[:branch].to_s) if @options[:branch]
      end

    end
  end
end