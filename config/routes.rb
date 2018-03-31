Rails.application.routes.draw do
  # get 'answers/new'

  # get 'answers/create'

  # get 'answers/edit'

  # get 'answers/update'

  # get 'answers/destroy'

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
  resources :programs, only: [:destroy]
  resources :questionnaires do
    resources :questions, only: [:create, :update]
    resources :interviews, only: [:create]
    member do
      patch 'root_question', to: "questionnaires#root_question"
    end
    collection do
      post 'order_questionnaires', to: "questionnaires#order_questionnaires"
    end
  end
  resources :interviews, only: [:show, :index, :update, :get_program] do
    resources :user_programs, only: [:create]
    member do
    patch 'get_program', to: "interviews#get_program"
    get 'next_question', to: "interviews#next_question"
    get 'end_interview', to:"interviews#end_interview"
    get 'retry', to:"interviews#retry"
    get 'show_program', to: "interviews#show_program"
    end
  end
  resources :questions, only: [:destroy] do
    resources :answers, only: [:create, :update]
  end
  resources :user_programs, only: [:show, :index, :edit, :update, :destroy]
  resources :answers, only: [:destroy] do
    resources :programs, only: [:create, :update]
  end
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
