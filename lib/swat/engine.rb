require 'swat/engine'
module Swat
  class Engine < ::Rails::Engine
    isolate_namespace Swat
  end
end
