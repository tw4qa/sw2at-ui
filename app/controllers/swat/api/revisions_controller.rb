module Swat
  module Api
    class RevisionsController < Swat::ApplicationController
      def index
        render json: revisions
      end

      private

      def revisions
        Revision.all
      end
    end
  end
end