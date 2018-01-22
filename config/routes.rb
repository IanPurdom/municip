Rails.application.routes.draw do
  devise_for :users
  resources :deputies
  resources :cities do
    collection do
      post 'retrieve', to: "cities#retrieve"
    end
  end
  resources :programs
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
