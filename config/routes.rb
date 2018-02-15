Rails.application.routes.draw do
  get 'user_programs/create'

  get 'photos/create'

  get 'photos/:id/destroy', to: "photos#destroy"

  devise_for :users
  resources :deputies
  resources :cities do
    resources :photos, only: [:create, :destroy]
    collection do
      post 'retrieve', to: "cities#retrieve"
    end
  end
  resources :programs
  resources :questionnaires do []
    resources :interviews, only: [:create]
  end
  resources :interviews, only: [:show, :index, :update, :get_program] do
    resources :user_programs, only: [:create]
    member do
    patch 'get_program', to: "interviews#get_program"
    get 'next_question', to: "interviews#next_question"
    end
  end
  resources :user_programs, only: [:show, :index, :edit, :update, :destroy]
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
