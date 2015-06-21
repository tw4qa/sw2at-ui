Swat::Engine.routes.draw do

  # Root
  root to: 'application#index'

  # API
  namespace :api do
    resources :test_cases
    resources :revisions
    get 'revision', to: 'revisions#show'
  end

  # Helper Methods

  def level_paths
    (1..10).map do |index|
      (1..index).map{|k| ":level#{k}" }.join(?/)
    end
  end

  # Angular States
  namespace :info do
    level_paths.each do |path|
      get path, to: 'states#show'
    end
  end

  # Angular Pages
  namespace :pages do
    namespace :revisions do
      pages = [ :index, :show ]
      pages.each do |p|
        get p, to: p
      end
    end
  end

end
