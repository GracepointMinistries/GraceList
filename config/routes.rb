Rails.application.routes.draw do
  resources :posts
  resources :categories

  resources :home do
    collection do
      get 'about'
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root :to => "home#index"
end
