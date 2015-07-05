Swat::Engine.routes.draw do

  # Root
  root to: 'application#index'

  # API
  namespace :api do
    resources :test_cases
    resources :revisions

    get 'revision', to: 'revisions#show'
    put 'revision/name/:name', to: 'revisions#set_name'

    get 'configuration', to: 'configuration#show'

    delete 'console/clean/:attribute/:value', to: 'console#clean'
    get 'console', to: 'console#show'
  end

  # Helper Methods

  def level_paths
    (1..10).map do |index|
      (1..index).map{|k| ":level#{k}" }.join(?/)
    end
  end

  def declare_namespace(name, pages)
    namespace name do
      pages.each do |p|
        get p, to: p
      end
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
    declare_namespace :revisions, [ :index, :show, :summary, :name ]
    declare_namespace :management, [ :console, :configuration, :about, :confirmation ]
    declare_namespace :components, [ :custom_dropdown ]
  end

end
