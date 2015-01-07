require 'swat/ui/controllers/swat_controller'

module ActionDispatch::Routing
  class Mapper

    def swat_ui_routes
      get 'swat', to: 'swat#index'
    end

  end
end

