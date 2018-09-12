Rails.application.routes.draw do
  resources :tags
  resources :products

  
  namespace :api do
    namespace :v1 do
      get 'out/getRfidInfo'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'out/getStock'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'out/getPointZona'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'out/getZona'
      get 'out/getZonas'
    end
  end

  get 'home/index'

    ###################################################################### root ######################################################################
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
