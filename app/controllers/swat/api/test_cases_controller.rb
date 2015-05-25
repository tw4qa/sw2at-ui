module Swat
  module Api
    class TestCasesController < Swat::ApplicationController
      def index
        render json: test_cases.to_json
      end

      private

      def test_cases
        opts = HashWithIndifferentAccess[JSON.parse(params[:options])]
        if !opts.empty?
          TestCase.query(opts)
        else
          []
        end
      end
    end
  end
end