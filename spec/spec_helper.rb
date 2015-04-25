require 'bundler/setup'
Bundler.setup

require 'pry'
require 'rails'
require 'swat_ui'

require Swat::Engine.root.join 'app/models/concerns/fire'
require Swat::Engine.root.join 'app/models/revision'
require Swat::Engine.root.join 'app/models/test_case'

RSpec.configure do |config|

  config.before :all do
    Swat::UI.setup({}, {firebase: ENV['TEST_FIREBASE_URL']})
  end

  def clean_firebase!
    Fire.drop!
  end

end
