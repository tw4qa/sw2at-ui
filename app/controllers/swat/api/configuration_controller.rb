module Swat
  module Api
    class ConfigurationController < Swat::ApplicationController


      def show
        render json: Swat::UI.config.options
      end

    end
  end
end