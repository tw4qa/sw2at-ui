module Swat
  module Api
    class ConsoleController < Swat::ApplicationController


      def show
        render json: Revision::Root.stats
      end

      def clean
        result = RevisionCleaner.new.clean_by(params[:attribute], params[:value])
        render json: { result: result }
      end

    end
  end
end