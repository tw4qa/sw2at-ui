require 'bundler/setup'
Bundler.setup

require 'pry'
require 'rails'
require 'fire-model'
require 'swat_ui'

# models
require Swat::Engine.root.join 'app/models/concerns/converter'
require Swat::Engine.root.join 'app/models/concerns/basic_stats_calculator'
require Swat::Engine.root.join 'app/models/revision'
require Swat::Engine.root.join 'app/models/test_case'

# libs
require Swat::Engine.root.join 'lib/swat/ui/rspec_commands'


RSpec.configure do |config|

  config.before :all do
    Swat::UI.setup({}, {firebase: ENV['TEST_FIREBASE_URL']})
    Fire.setup(firebase_path: (Swat::UI.config.options[:firebase]))
  end

  def clean_firebase!
    Fire.drop!
  end

end
