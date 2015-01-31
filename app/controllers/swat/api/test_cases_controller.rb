module Swat
  module Api
    class TestCasesController < Swat::ApplicationController
      def index
        render test_cases.to_json
      end

      private

      def test_cases
        [ { name: 'Hello' } ]
      end
    end
  end
end