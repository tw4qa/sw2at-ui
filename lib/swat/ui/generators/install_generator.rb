require 'rails/generators'

module Swat
  module Ui
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        desc 'Generates Swat-UI initializer.'
        def install
          template 'initializer.rb', 'config/initializers/swat_ui.rb'
        end

      end
    end
  end
end
