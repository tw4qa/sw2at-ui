module Swat
  module Api
    class TestCasesController < Swat::ApplicationController
      def index
        render json: test_cases.to_json
      end

      private

      def test_cases
        #require 'find'
        #folder = [Rails.root, 'spec/features']*'/'
        #Find.find(folder).select{|f|f.ends_with?('_spec.rb')}.map{|f| f.gsub(folder+'/','') }
        TestCase.all
      end
    end
  end
end