require 'bundler/setup'
Bundler.setup

require 'pry'
require 'rails'
require 'fire-model'
require 'swat_ui'

# models
require Swat::Engine.root.join 'app/models/revision'
require Swat::Engine.root.join 'app/models/test_case'
require Swat::Engine.root.join 'app/models/full_revision'
require Swat::Engine.root.join 'app/models/revision_status_calculator'

# libs
require Swat::Engine.root.join 'lib/swat/ui/rspec_commands'

# Fixtures
require  Swat::Engine.root.join 'fixtures/firebase_collection'

RSpec.configure do |config|

  config.before :all do
    Swat::UI.setup({}, {firebase_path: ENV['TEST_FIREBASE_URL']})
    Fire.setup(firebase_path: (Swat::UI.config.options[:firebase_path]))
  end

  def clean_firebase!
    Fire.drop!
  end

  def current_data
    Fire.tree
  end

  def recursive_symbolize_keys! hash
    hash.symbolize_keys!
    hash.values.select{|v| v.is_a? Hash}.each{|h| recursive_symbolize_keys!(h)}
    hash.values.select{|v| v.is_a? Array}.each{|child|
      child.select{|v| v.is_a? Hash}.each{|h| recursive_symbolize_keys!(h)}
    }
    hash
  end

end
