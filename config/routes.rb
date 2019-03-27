Rails.application.routes.draw do
  root 'homes#index'
  get 'homes/use'
  get 'homes/protect'
  get 'tabs/index'

  resources :advertisements do
    resources :comments
    collection do
      get 'sort'
      # post 'pay'
    end
  end

  resources :conversations do
    resources :messages
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users,                only: [:index, :edit, :show, :update, :destroy]
  resources :favorites,            only: [:create, :destroy]
  resources :relationships,        only: [:create, :destroy]
  resources :conversions,          only: [:create, :edit, :update, :destroy]
  resources :evaluations,          only: [:create, :edit, :update, :destroy]
  resources :twitter_informations, only: [:create, :edit, :update, :destroy]
end
