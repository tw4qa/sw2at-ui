require 'bundler/setup'
Bundler.setup

require 'pry'
require 'rails'
require 'swat_ui'

require Swat::Engine.root.join 'app/models/concerns/fire'
require Swat::Engine.root.join 'app/models/namespace'
require Swat::Engine.root.join 'app/models/test_case'

RSpec.configure do |config|



end
