module Swat
  class ApplicationController < ActionController::Base

    def index
       render 'swat/revisions/index'
    end

  end
end
