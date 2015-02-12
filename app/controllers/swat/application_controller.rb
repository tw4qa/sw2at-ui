module Swat
  class ApplicationController < ActionController::Base

    def index
       render 'swat/statistics/index'
    end

  end
end
