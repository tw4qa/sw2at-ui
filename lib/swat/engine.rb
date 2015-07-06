module Swat
  require 'slim-rails'
  require 'sass-rails'
  require 'coffee-rails'
  require 'bootstrap-sass'

  require 'time_difference'
  require 'tarvit-helpers'

  require 'tarvit-helpers/extensions/counter'

  require 'daemons'
  require 'daemons-rails'

  Daemons::Rails::Configuration
  class Engine < ::Rails::Engine
    isolate_namespace Swat

    Daemons::Rails.configure do |c|
      c.daemons_path = Swat::Engine.root.join('daemons')
    end

  end
end
