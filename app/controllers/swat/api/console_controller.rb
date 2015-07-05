module Swat
  module Api
    class ConsoleController < Swat::ApplicationController


      def show
        render json: Revision::Root.stats
      end

    end
  end
end