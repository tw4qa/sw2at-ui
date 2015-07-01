module Swat
  require 'slim-rails'
  require 'sass-rails'
  require 'coffee-rails'
  require 'bootstrap-sass'

  require 'time_difference'
  require 'tarvit-helpers'

  class Engine < ::Rails::Engine
    isolate_namespace Swat
  end
end
