Swat::Engine.routes.draw do

  root to: 'application#index'
  namespace :api do
    resources :test_cases
  end

end
